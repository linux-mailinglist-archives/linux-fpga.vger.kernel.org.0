Return-Path: <linux-fpga+bounces-1102-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700FA5C5FA
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D3F189B19D
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D8249F9;
	Tue, 11 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NDpdN/yX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AF1C3BEB;
	Tue, 11 Mar 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706209; cv=fail; b=lSFJDTZzMAwApeRfbgqRxfSX6gjvJHcvcoIloKzSM2yFIUqQV4tlwzdf1GrCH9uidsJGUHN1u8/GkysDxZnrDkQONvHZa35s44VHhK+wuhYt3ljc1ZN6J3m7RS6vNZQxvNkFOSybZPEHZMGW+zdXIScZT2RqQH73b4JCm/uZokk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706209; c=relaxed/simple;
	bh=oAQKxTQ7z6XxzaB7y6hONmmOiu30JE0kClbyMG1dZaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L6JIpfAeMiIjfLClSywAn32Kpdt6JYv6x4LuYIhClBCNfRciCWlVG6WqsIkscBplu0iZuI7z73o2xOHMrINse2Ei0tPi3Q7lzrKqLicBmZelAPXrxxn0PzuCw8kkboyvVbdvu+HsSTZUCO4zNt9pKokMd8fPf7c66+wo58IoFYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NDpdN/yX; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3lr+/sggLF/k+NenjFCMfLu+m2lUmwdgOqHfQh2lSdWNaCUARJejAliFZAO3x3uSTSmFY0omzzf/0jkIHY2FH/C916ArDQXQeEXWuIFTE0xcRBZpecYJqd0LLLpyJ5iAukRjd0vHygxfUcmTXwZZVTgUX1TQ6Gxq0ioD0nYRATCZKXCx210CHCGNHTQgwVnPAZOab0XZnD+vy/ykda0b9JBWzL3dZHaK7dFG5yq/lEzUK/byjQfcM8A808PDA3qznI13mFCM1WwZjrv1VUWTH8Yz2H0b3RX2e4r70kGS2KqmfpREaQ9UCS1fhzdJrp2+47Xwcm5yTQ9m3jbkfDg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJVMlOJSuewbm73EBPSnhC+eoLPJfyMAwczBBqNTtg8=;
 b=VE8Mp0fxOb526XlD+wXGbr0v0LrfpGKUks+rungooq6M2KGyjRhgZiV7TdcEBYvbwa7i8ngp3m4l9VY5Ver5d+GxakfuGzhOJNpgFyOgQ195h/kbrDU1g7sOZJjsrJPJZ5nVsIbgaTcdeZqFXjMY6OPVEk/mxiwi8MDtBnb+hsgskiJ5u1xP3SdJxUNqf7I+jdu4BxZzT87Xeb1TGTMRju+dc0b2uVBqrlpGYr5TKi3kIdEBU+vCJvV/WZRvPXIN/x9Zw2eToFkmR9YTq6MU6T/IDrvDqWwoxweFu0MkX4jGhAI/hmY/yhX3Q6+ugjTquFIBrE7B0xuuOorGgCcr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJVMlOJSuewbm73EBPSnhC+eoLPJfyMAwczBBqNTtg8=;
 b=NDpdN/yXlMCMx7/ylrqj3L/nCOmqBCfI1I3fR2r0eI+lRNBLm8fQ4dQOBlfRpKp37YwGhuCfArCeWT+STfLN9hVJILfiLeCAnGbPTeIQIS+QLHF1NPUxovEFZ0UVG0E3ZOZhhbcYWvci7GtNUQXh2xPzXdNeJEMJijy/q2x1Sx5mUhWNL1L9LEiSuokeRiOqmpwk6HS3Yi69SOMIQOG055KRyvmYKRY3T6G4W1DWcT726oLHhEQUROF6MZs4WzIbQduxHsbRvRUkNK/ipBa0Ms0eg9+OyU1O98tudEIwILcfhPTNj7ywAKDduej15xD+OLnoV9d4jO2om97WzYhx8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB7039.namprd03.prod.outlook.com (2603:10b6:510:292::11)
 by CH2PR03MB5317.namprd03.prod.outlook.com (2603:10b6:610:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Tue, 11 Mar
 2025 15:16:44 +0000
Received: from PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55]) by PH0PR03MB7039.namprd03.prod.outlook.com
 ([fe80::b6a8:6482:2dfd:4b55%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:16:43 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanmay.kathpalia@altera.com,
	stable@vger.kernel.org,
	Chiau Ee Chew <chiau.ee.chew@intel.com>
Subject: [PATCH] fpga: bridge: incorrect set to clear freeze_illegal_request register
Date: Tue, 11 Mar 2025 08:16:01 -0700
Message-Id: <20250311151601.12264-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To PH0PR03MB7039.namprd03.prod.outlook.com
 (2603:10b6:510:292::11)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB7039:EE_|CH2PR03MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad25d2b-90ce-4a6f-03a7-08dd60afbb66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swR+fb2zGgzueF7FaR6Z1TEtdj94+c9moL+VXjhZWH5ae8pYJxxZcsrxbYBJ?=
 =?us-ascii?Q?YWGz8mIjk6HM9dsmWDkSTdk73p5TdzuXM2IglAtnYN/9vhBpdXOw8dvOUFBS?=
 =?us-ascii?Q?3N0/o/714BVGXL41uYb8+chDHpM9+9dJPDGsX9u/5fIGzea7+PuIre9RGMeq?=
 =?us-ascii?Q?cjRyH1svvymagI5StBXE3AIkNvKBk+KBEpQrTRG3Tpzn1sbGRi+p9h7uLCBn?=
 =?us-ascii?Q?OWQcNIzNwp8wEx+LXmVeEnunuAsyXYn6Lz87+MzppoRbAeoqp7Zn++aTui+7?=
 =?us-ascii?Q?LIgeClTN67mXLYEQhe7khz2hWWQqUmGRe/a4fJePIgjcDiH1yLe1CLsZH8sj?=
 =?us-ascii?Q?GI9adZG7oLsg18WaPq2SyjLMplT2iPT9N5Wtn5S6YkkexOKOyTugiK5jgvC4?=
 =?us-ascii?Q?tx5QUC8nAuKOZbp42H1ueZqhPqz4I1FxPtlg9lKTw/3gCZ4Xcg/G2yrUWYf5?=
 =?us-ascii?Q?PxU2YNZYJ1wNdf0yk4Sojn7VO1frPOx6yaxBeMfQeB6/Wl81CCpjvRslU96A?=
 =?us-ascii?Q?hI3ZsX1BsMR+foGhSGoFbn3rEu+OnnpIlSWm4UuXJuq3DRXmMwQ7lgtkLzIi?=
 =?us-ascii?Q?MDc6P0vArgp74bQC1Qg3l0DV2G3gmLzAmwmw8X7sxEeuRS15ixiUvt8sItX1?=
 =?us-ascii?Q?NrLvfZ65lbi+cjYLEj5s1OCofjeelopGzOUNcU2Cp5x7NRxxO9wDxOHwHtdf?=
 =?us-ascii?Q?p+XZJjhfbThYZtqu7Vl83hYlNj5MHaLpO3NCX4mITvRu11RTC+PDM/znP48U?=
 =?us-ascii?Q?58oIq9oR98M5VhRH0ua4D7i5SEM86fZt2dFpnKGk3Qp95/lSTO1gA0jQyuna?=
 =?us-ascii?Q?Yvy9ZibWNkMRhKX+J1kQiZkll6zfRpfWp13a8XtABCa7yIXcIef7UhhedTvy?=
 =?us-ascii?Q?QZZGEap/SIvy0w+cQO0Wg3hlwaPgZH05V0GDCA63VUI585XntcfIbCI6MdK2?=
 =?us-ascii?Q?PjZmY8scwYyVgdPpoS6vpPgtwUHdA79+UDxqyJYhAKgWBtt7YOuiwuK7zpy0?=
 =?us-ascii?Q?bKXCeD0T66pNU5rMfQciU4qZn4mkj7a4Piwu5Cpqt1lal9KZGcZP1js0Yd7h?=
 =?us-ascii?Q?IDyFOp9+7Z7elQtzXe2vgW+x78PJ/JU8F9pw5pWyr4/49aLYNVcbjkjJw7Dh?=
 =?us-ascii?Q?mJ0wlj3aV1nIdFJoc74iGUlyZ43A+M7Pliex2AQAyaUrkP4eiJsIzS1T6MZ1?=
 =?us-ascii?Q?vbP55jiI+Ve8LrLNaQ22RCklGGI5po8073qqNagSywCjBQyJUoS60fRutucX?=
 =?us-ascii?Q?EhqUgwda7gAPA7ORafTrgt5EczTGFUS3po2A3N8nx0wtPcRPCctbxW/yD3PI?=
 =?us-ascii?Q?9YAIw05tEaXRDgY8Q6w+awSVkc9HzTy24pOASNwVhbj5XsB4zeV6ks6XvnvV?=
 =?us-ascii?Q?ezZfi7BmVH3bFgbALPBW9JYkmUH8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7039.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQJdQu3Iy6n2xUtpD6PG4n0XLvS1B93eGxbs/gI4GSm+y/InkZX+B29WE3vy?=
 =?us-ascii?Q?7KN6bjF57VwKJ3DfJcqyYOH0lzs7oJoxGeDkL46hba9h28a2wAJOB6Cw1BCA?=
 =?us-ascii?Q?+st8KTRwHbSJUEl9A56ZYb15IOo10jNQ6hiHri5aHRgn/nLnvVy0RQCWilaL?=
 =?us-ascii?Q?zLOMVafLCnGG5iD4/oeTT4XP2IY2YnumUQCIzB2obJcoeYYf5AEzFMhK/5+/?=
 =?us-ascii?Q?uqdcK+gTpNQKYy/M3PRGT7KmtagkDmD2s6CkcIIGLnGTY67tiNiL3x4P6vwg?=
 =?us-ascii?Q?kMwyDaWBwm3tb2m9YkGTOdiXG8ZXT6cXATL21ApRxGlzE5pq/UA3TWvi3DRg?=
 =?us-ascii?Q?i68LIIEC4MVLGh5VAPhiNLZy82g1aGZMzIGXitbfEU6okQ34rJ6EnVaglQgs?=
 =?us-ascii?Q?IYN9kyhuaJl7k6NhklXhon4aKMsq7owvQvW1X2Wh39KgTOgXWO5BdGUkMpsz?=
 =?us-ascii?Q?CxDU8O6Cgk+TbUH6kppGMCvjQnZBDfmUQTMfC+xOJ+Fv4hyBYet5ZZV4ey8a?=
 =?us-ascii?Q?ifC/utay4oBKKIAxioNyVB7qSNrpi5N+pP0I46XDvvrF+N3g/2/5fmDqbVTE?=
 =?us-ascii?Q?w3145Jv0kT1Y1mFF9bFc7rJLMZgtzoG4OStzwt0Ye7URxL0QTo7Lb+b+LZ9f?=
 =?us-ascii?Q?qmJrVHGd8z7v2BTr3X49th0woDNYnQcNlPA6rO/LR8CqOKmTwBuzcjPpeSHt?=
 =?us-ascii?Q?awBEXCA9byUZkKYcPfIO+SAQ3rVMMz1ZvueKJjT15ubn6J/Gj9JflxRiygB2?=
 =?us-ascii?Q?bfZb1ojNYkZyvytmWdP9ZYvTxujNyH/WJ1oxZDcIaM3O3F9Av0P/YI849Nc7?=
 =?us-ascii?Q?jNLOuDxfvo0yikNxWzolV/fRCqS476C0pL+VGaU3euHmlifgnXNfZ1LfQOpl?=
 =?us-ascii?Q?hWyduVZu92PxqrKep8NTGxgVW3C7yyRZ01wExdL8pExP+vnYpyLheo3dJ1Ap?=
 =?us-ascii?Q?XFGoO/ExagygEj6r16tD9XZUlL8sv8i5bJOvMi9MKANYYf+Z/ko6zn8zcdkb?=
 =?us-ascii?Q?RkJdwn9y3iCc1MWruRF2XkNMPqPkYynEhtCGkdFkcX4AJOrC+oTLDeVCyF0x?=
 =?us-ascii?Q?0Meqkb9XJOlqgQrM1pCoF5t6MCg5Dr9alHhP98KjfqdVbaqkSRUXYsBmP8ta?=
 =?us-ascii?Q?O//wGZJV5NY8wUNvnSzLPk03cY/aWfjE5QwNVFL9CLUwT0KDUlWodvUdxWYo?=
 =?us-ascii?Q?EGXXYqlUIN8O/bG+dUr0H7ueOrqX0ELXIqn4rVnhTzieMbp+G1H7U4I8u0j0?=
 =?us-ascii?Q?cjmIcOIleg7Ur//e0Y3v8AoCBxuLzFuEPmgZHD+uVU3ESUPjiftq8edzsud4?=
 =?us-ascii?Q?z89afT8pr9rvBRFer/7myLnvtJ2POWxejniQx75ci1PntWquhj9uFIadzgds?=
 =?us-ascii?Q?vrHsjBXL+YMQ5V95s8OeLnekb5MKLvgW+9CfsOg0d4wpj3r6863nZ5XKkyhN?=
 =?us-ascii?Q?IH5LZ2gs0rbeifKARuW1r3F56IR3H7jC3xSmLAEqZuv4QWOhoNCrJJR2N2ml?=
 =?us-ascii?Q?3Yg9aIKbmicCuGGokcStcICoOcelUGlADAnFIgwpL1gJcsXXttjcm5O1a7ug?=
 =?us-ascii?Q?Ob6o0htn96rmOwwoCGu/7cGCKoc7R6AYqJi76kQmNHyedcrRxIW3YyUV4v6w?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad25d2b-90ce-4a6f-03a7-08dd60afbb66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:16:43.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZYdT5HTYvcFV2o9BAWQjKD5am4P4OhlT8o+bCWfZwatAQ3Y1Ug48DqgcOuBoZb5vgGuwhQ/JgvLw7YgzsURfCEv6vaU7Gm22cwV9PQ+sWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5317

A Partial Region Controller can be connected to one or more
Freeze Bridge. Each Freeze Bridge has an illegal_request
bit represented in the freeze_illegal_request register.
Thus, instead of just set to clear the illegal_request bit
for first Freeze Bridge, we need to ensure the set to clear
action is applied to which ever Freeze Bridge that has
occurrence of illegal request.

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Signed-off-by: Chiau Ee Chew <chiau.ee.chew@intel.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/fpga/altera-freeze-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 594693ff786e..23e8b2b54355 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -52,7 +52,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
 		if (illegal) {
 			dev_err(dev, "illegal request detected 0x%x", illegal);
 
-			writel(1, csr_illegal_req_addr);
+			writel(illegal, csr_illegal_req_addr);
 
 			illegal = readl(csr_illegal_req_addr);
 			if (illegal)
-- 
2.19.0


