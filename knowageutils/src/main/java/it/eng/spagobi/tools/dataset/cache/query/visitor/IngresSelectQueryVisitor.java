/*
 * Knowage, Open Source Business Intelligence suite
 * Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.
 *
 * Knowage is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Knowage is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package it.eng.spagobi.tools.dataset.cache.query.visitor;

import java.text.SimpleDateFormat;
import java.util.Date;

import it.eng.spagobi.tools.dataset.cache.query.SqlDialect;
import it.eng.spagobi.tools.dataset.common.datawriter.CockpitJSONDataWriter;

public class IngresSelectQueryVisitor extends AbstractSelectQueryVisitor {

	private static final String DATE_TIME_FORMAT_INGRES = "dd-MMM-yyyy" + CockpitJSONDataWriter.TIME_FORMAT;

	public IngresSelectQueryVisitor() {
		this.dialect = SqlDialect.INGRES;
	}

	@Override
	public String getFormattedDate(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_TIME_FORMAT_INGRES);

		StringBuilder sb = new StringBuilder();
		sb.append("DATE('");
		sb.append(dateFormat.format(date));
		sb.append("')");

		return sb.toString();
	}

}