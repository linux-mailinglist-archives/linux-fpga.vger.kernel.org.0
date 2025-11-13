Return-Path: <linux-fpga+bounces-1446-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F70C55AEB
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 05:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 770FF344315
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D22FF147;
	Thu, 13 Nov 2025 04:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RMAg7p5L"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F98248C;
	Thu, 13 Nov 2025 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009054; cv=fail; b=AS0Lw+33uhHI+NDeBiKdGr7j76okPzjEes0CoFJ1bNKNShucXpxBnPNG0EN3YniLubhbatZkKuzZehUoFIDhhNyLPEbZoYi70fwDq9rnI2dCTgf03IPEHMT1Swwm2Y2IjULLB2cTn5YIgXAeEiLaiyZYpz0TX8E1JISXL1YZqT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009054; c=relaxed/simple;
	bh=Ne1OA2n9zG9f7ZjCnuA/Djz7e2NF4xDskDgPNhDbWTk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hLuT2A0xEN0EDmyZibmDdZUC8cupLrdD+kECp1vk2qpyALbVf5oDhKr+MVcQGjVfb+wWgOXZVw+Lsk1ALnISqjPEdH7vtBBhmFaOhDkZpozJW1G1mjXg5VP2Ek5sYNzfBtnzCfnAAccJ/39c+tOmgvF7sKnIrll7T1gXuyriAZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RMAg7p5L; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQlTdAAPHd43GKy2XGD6SnQRtvEKSL5vWYTt+8JdIpvUXw91PiKKfDlA6Cjh1P6JLMiUl10py7C2uDJhvQ2VDGmIdRg5ZlVhW7mnZSqrxgrmrX3UWtR9/ILisrTRn3dHvG24+7GZw66WenBaJD3DfcxTrkKg8t64f4bjpbxvmtRNJUX+d7dgPdDtjuctOOVu2gyk/w5s250cJ76nnWsz2xQ6C2CXrXY+0L2zLBwqwLKAeJPLR9d1fW8XQno8znDhssxxPL3GduESAWFNqhOHg78xGBKqzhGLM4UF9Rs81ksctXP146OBBJT2vEQpooOW4FFhdajxiZH8e6T0LTww/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icB34owfvtAeMzHpyUr6T/M5PJBdJluliT1dC/nkv0I=;
 b=UjTRMfywgVwdO2nE24olHZGKaBBbKkFCxBFMqn+Mk9pIM8938P3IxUV0fDjTcxYowsflaUvgUfUncKomwivPLdr1hxfI6tE64cc6IX0hELKCsU/M7597IBvkJ+HGzsdnRWRXKs73V4C1lIy3JjsA7iH37F2o8t0HGoDBZb7ECXQqUvxXuINCIrVnYWoakS4+DUo/FaAWxBi5TJNXBsVI7WfNoIwJ8it9vCl5n3O7W4bvkTHEHnC/VCVX+pRJoWPF7uBBJnj7WgeIIAtzJewzzYpVldKmXr1XRpVBdeGDcXI4+kf/fnj+U6Ab043sMlji3+9eZ6kPCDd0SC2J22Ygaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icB34owfvtAeMzHpyUr6T/M5PJBdJluliT1dC/nkv0I=;
 b=RMAg7p5LGxp+4ESL6px+q/u6CmBhfpZwPSsHQhZeyBv0HpBe2UVyLMg97uFas5imA9X+rADIGQRvsNtSFXuPupzhciw8vIGKCB1zzpLB1/gd8zH6qPfucPXLml/9Wd3EVgs0K3cr+/Dz8J2feUMRfYr/f7sP68VdxXCKuHlC1CAzWLVc2aEIGZhqDcyP4fAeXwFpTNfza8luW2cTLQK/KkIcxMOjryY96jRALOMwHic7mnR/WqyV0/fo1xo95WAulE0EdzBEoxVz6i8cPi0sChwEQLVpG+8wF3SCfhHwf+BzNgXPRSLgB0pALk72UlY+sZ95WSR8Rgynza7NqW7oeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH7PR03MB6862.namprd03.prod.outlook.com (2603:10b6:510:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 04:44:08 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 04:44:07 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Date: Thu, 13 Nov 2025 12:43:54 +0800
Message-ID: <cover.1763008269.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH7PR03MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdabb8a-f855-4045-9231-08de226f4588
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6brLFUCi3ocNBjzNYm16qyNO4tReqwyxOcDVfU1CEaFhDEphihOB9rWlDEUb?=
 =?us-ascii?Q?QN+eF/dWwsT29fVbI/j1RGEAdRGL1suHvw5UbyofOkTLU5hjXgHO7BnY2TTb?=
 =?us-ascii?Q?ldfrgVqn3s2lH0hrq1AINBaYqK/eUEZ+mnQaYpm0iVeG37plwqtMBGjNy8mK?=
 =?us-ascii?Q?2ybcGHpBtbYJpJQD75NkDxDJbWOCjg1JBT1TSltCPqTMZlesvj9SnaWZKYx4?=
 =?us-ascii?Q?+Kvfemc38D25GOtTJlSLNgxmyEcnxCnrmxYRlDKZBDFWb3YBNbMysRecKqXB?=
 =?us-ascii?Q?yc4CQjVfW2zeFdjN6bg/s6h3rm3Cnx3/HYliLEBe6Mkqx9NBU+3BDnaIdjzK?=
 =?us-ascii?Q?vOhdSxAWtTjZYL0tJ2T61tHcg00C8ZeZCZvbXgvqZkJlhP0CaA66vPtfjSgx?=
 =?us-ascii?Q?BK02IQ5RuTriYVoOufAxCs22OiD/gv1JIfXgIY0PU33+8woj74/q09qPV22u?=
 =?us-ascii?Q?FYZZGtWSGAKZQF+dxPH4cLis2N+HpwrsJXq02/L/x7YcP9P7yQ7dv1PB+p1L?=
 =?us-ascii?Q?PrQuxMGeHoN0LZHY1avs+pNKhIWWBqnxke7rK72mdNhnFuyCxVxGSsStSTMY?=
 =?us-ascii?Q?8JWdRhEOzwfflfVUXGvPI+LJg9rjt4YnAza16JGYmo4bYcT+Zmt0WPkt4uMx?=
 =?us-ascii?Q?ntu2SSPz/4Sni/i4ykREM/WT2SlXwm3e9uNf4Wg9j1FmNI7lbbfSQfS33mSm?=
 =?us-ascii?Q?r6KnbjT0O2i5zNBp3JHqAvcr9RINmI9f84KZYoVO6osV32cMHjMyP87EOeQP?=
 =?us-ascii?Q?bFZrWi40/ppcSp+TungfKUMGATmyWkdbAsb6mX6BcJFmZ/wMiux87K8ZngVn?=
 =?us-ascii?Q?/H/Z2UMWbDgEZeEzx/w6t3hZ2DjrHsK5WeNGhHxBp/wF+OLMTwtjE8Pi/Bm5?=
 =?us-ascii?Q?yGRXl9SIVVP3P2HAIzb5RopKL3z4AisaAtibCVz3oSI/Ny+N8T2FnaQBi1RH?=
 =?us-ascii?Q?JSBLqmFqQ9gp1jMONkjXHddvRp5221+yH/oXLApy/JTonyBfuJxrHZUGFwEZ?=
 =?us-ascii?Q?tiHkO/ugDeX6to0hWYKUSh9hNrBBYk/2yZHqKA9VvLv1UeN4lqy0sYe9cbri?=
 =?us-ascii?Q?bwyRmDEYmwpyDcifr9+qjYhrxWikXxzSBJZFNwLJY5LzHM32gik1KiOA7s3H?=
 =?us-ascii?Q?iZRWTC/1AFoKEQlHmyL7fyo5PZLVq6lFzmHHRV0p5ypLiRczdX/EvmAQzs+9?=
 =?us-ascii?Q?+OW6M6v4umWggENpROCWtrtOnSiwX0SXY0S2Eg2VlXg4/iDRG3abF0dMUJaE?=
 =?us-ascii?Q?CkKRdXnmGbbIxw/ECNZwtAEWeXUcfcQFUZxlzjhlGaZ4vnpE361EYBIsAa6Y?=
 =?us-ascii?Q?JpYsn7Ms8CbYBx/VJUxQfPsCotnwTW1DvcVqgmY5yEWGLiG3OU+UzBX+YxPB?=
 =?us-ascii?Q?RuAknWB+QD3UV8CwoPg7GVqVZ9U7I11CqrfiHvjPhk+nZNbPYYrHOuVhgLx8?=
 =?us-ascii?Q?cU6w7ernVRsGH44VBWtB291I8pESy71ZFiu+zv/3QIQ+oNEHX+fDIk0NxsfE?=
 =?us-ascii?Q?g+w28ilIWVnk8mW3quEzdVrq8MNNIbIECTlk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bH4VTz6MCZykfl22a5cLdiBuAcdlmq/rzVUz4CPz6IO5cB/XIjU3iNkYjzzj?=
 =?us-ascii?Q?/woO9G5MVYq9tmQE8MroxE6xrR19cYmVndYu29RqiMrRaWSl2jBI1WP1kF0X?=
 =?us-ascii?Q?fi7PJU+MWn0PVReubKXp9t7sXG9TKQqTOj6S5jjK3nbZlU5z77l3XZMGz/Hg?=
 =?us-ascii?Q?/Ff53JQDJ+I7D+y9BD3xU18jS2UqFtcn5N8TGPnzrLZqlq9j85zb1W493PeZ?=
 =?us-ascii?Q?TyIIIKl2ygViyEuUF8hlFitwY8Nmtv1nEqnvKZY0S6kQhR+ZUH/0MzHhnKno?=
 =?us-ascii?Q?WRvbXqAPSER88E1uau9ad+kppyyaAP23WIL3r9nF3UwspiMNVty3xWGoHcP5?=
 =?us-ascii?Q?RX6EUPxhhqQ6wa20Vbi9fuMEhm5VGGyK13cjd13l+k7BdkSgQoz7OgrMZVXn?=
 =?us-ascii?Q?K0ENqbJVkJHMkc88/y01VUHJfyL3nZN86S99er4ZrnloE4s/Mj9oVUfcpU6V?=
 =?us-ascii?Q?ZmLusehrkydEH8YPTO5ZA/fIcHLSmQ9Z7auO9tvw97Rged7yIxh8OHpgeGKG?=
 =?us-ascii?Q?2wVpUF74dY3P8VFwIq5FQEojmSfgR0qO2B5WqpjZlI+wyhnBte+EMb2G6Pha?=
 =?us-ascii?Q?LqvjQcyD9o/aDyxalNpQ4aJVQCWma8hBjZ3OcWoC+RAYuPMYIKmkdFf4T0Y2?=
 =?us-ascii?Q?r5FyO9lOBrf5tZMcTjI3a+QStFUOEREGGdwNUAXbWQdKj03dZzTlofe60lYe?=
 =?us-ascii?Q?50nKBsPjCfFapZSFih7wXTfrRr5jN++lyC3UXq5H5b2VaVaEvbWwlK7+w7b1?=
 =?us-ascii?Q?ALRRvhtK5lnTfwXtm2Ah1WzEKgw3z16qDCefyGXfy6Ch50tJffU4byKYUDjx?=
 =?us-ascii?Q?ahzKWtRuCQb9mA3bJSHCCDcdd8JJ98QOwbQORcAIeWvlqzkJdT29jbSbQ7sb?=
 =?us-ascii?Q?+K0e6WRrfPHUW3CApjccU/+VlevVEb81yJOK6bO21XPD/+kzCppcpqOJIdkp?=
 =?us-ascii?Q?/cWtzaTTgYLy/kMkSAr67uRiglQNxjB/X3/ARps3RvyNSX/mb6S6YDeeeTQS?=
 =?us-ascii?Q?HfbcRq+3Td/R1WjLmiCCPcDs2MBbJ26GH+qLE9nYALT/Smh36aIB7h57+OCB?=
 =?us-ascii?Q?Sth2YleDmP5fFcTGf8z653Bet2vwhdPDZJMdZAvnln53pimpCNsE0XYaiIhB?=
 =?us-ascii?Q?FZjHNaI/0pvaWo9dMXnAYCXEQIgtItSbmPhLrYNat0h+rdPY90AI7Iywqg43?=
 =?us-ascii?Q?XIkbbIZUo9zgjuto6w2lpjRuE6OO1DvyJachSqSXxpZCSzPOj3lqINnidvFQ?=
 =?us-ascii?Q?HPBcNJR2P2sPRpdW7FXMan0hSv3HJiNUgw7tlFoHfxCgobcTy68MT4CWYGf8?=
 =?us-ascii?Q?Z/lpr3C8rKiKIbZqY+yqW7jIIylR6yCZijst7P43JcM+s4XTsFMxZ0zkVXkB?=
 =?us-ascii?Q?F8p1P36vO9qTt+zlfh0g1exnoIHz+s2flIq5uELP8WFOyzsqTtQEOxT+SKXh?=
 =?us-ascii?Q?PLXhdto3uitY10etDtsipUEBa1VhjaEuaiolFBKKmPK6oS5geJinP3DKdjuJ?=
 =?us-ascii?Q?yQJgy/iOOzLUc8RqIDdzGoLLdu10Uv1Y+CSLIOyPaXt0jSNVNqNiS0ZaLIT5?=
 =?us-ascii?Q?hKZhsp0JWfs2UmKPqDi+LeCA4rIWOOfb82qq6Kri1EbCFkKMZ/vyrZMQGMs4?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdabb8a-f855-4045-9231-08de226f4588
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:44:07.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQpjwP1TUnRS8wj47/bjIAXTo/KbnqUDvoHiVTV7fMyGDqURwzgROeXJpPuJo4m16yXlSOVFKBViYStbnhWSkU5ULuvuFQigX5YdmVY+aAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6862

This patch series adds device tree bindings, driver support, and DTS
updates to enable FPGA Manager functionality for Intel Agilex5 SoC.

These changes are intended to enable FPGA programming and management
capabilities on Agilex5-based platforms.

---
Notes:
Patch #3 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory
region" from
https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/

This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v2:
	- Drop "fpga: stratix10-soc: Add support for Agilex5"
	- Add fallback compatible in DT
---
Khairul Anuar Romli (2):
  dt-bindings: fpga: stratix10: add support for Agilex5
  arm64: dts: agilex5: add fpga-region and fpga-mgr nodes

 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml  |  1 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi       | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.43.7


