Return-Path: <linux-fpga+bounces-1425-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A576FC38D6B
	for <lists+linux-fpga@lfdr.de>; Thu, 06 Nov 2025 03:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF23B7C8F
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Nov 2025 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046061CAA6C;
	Thu,  6 Nov 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jNDqpo0B"
X-Original-To: linux-fpga@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFC29A1;
	Thu,  6 Nov 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395319; cv=fail; b=kSNRUoB8ZdEcirkROreJ/mlNd16Ibxi0kPjJr6XVn2AoNO1DyeRISgpUfV8Zwzr12zWR0HfwmZf9GHCsrGwNFnqLwrUDA1Rty2eis70e5QYH6GKLvTNwtiEP8KrUuVlYw6ZrCxH21FwWYOvSJVz2AF/vrlvFipEwDIFvzoo215A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395319; c=relaxed/simple;
	bh=Imb3kXQPLrINoBj7xtLx+Vj09wCQvL/i/jgX8CAEgdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9R6uIwWtmEF6b6811uBZHfr34cz1Q59FrTqDArsQGYZQInCbD5yD32v+9Wvp61tk8Gm+FutuOzywjUM4KpcEA3prU0WOmaP3Dma/Z+MmmLLo+bJ3jN/Utpnp4jMUeKBdQpO0jnKc16FegurEq+Hwp9+5yh7JZKiguWlMBAmnQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jNDqpo0B; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYgUjVoYwPOj6LkEcFaSCFrztoskgMpIiGOJVWdVU//Sqv/5lWSXC/dRqPAXwvffEzLD3dnR43JErUcdoNXZHNENWNtUxRtKFAZkeG5kP8aywqHJ4IYxuZwL128wBZfPa2voN/K6fK0ar68zGHn9ttfGN4UtAwReCv1tGNKMlSfPStqvvqO43+Ss5RqeEnMMZurL9WSTY06gRAGjvwAz8K2jgnPTpRd9RbOBSDuNzcSTR7cgNf0YnRttyAxhhindx/JZStBFX4+2Apg+Rtm5TTA6Eujg/kFDx0dPSS8jmVQ5NsgY9cax4UwQy2/KzZGgYGKHtgeZ4dZFVeDepAmQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdYO6XRWqbqk7YvQFBtJlfkclYx+LVhFFb7WHNiN2Lk=;
 b=la846tQYT+dfGyrk6XOCuukWF7ddZ0dN/mBRns3q5z4UHhRGvm8EBYn8ShhNPqa7ZnMJu1gszYpN91Qkn7z/e9MBLnw+a1GTkrLYDxa6OZyAIMQV2n/aO1IVg/pACuapJfUFTajMcMzGy3eGw7JyHnoUnmEILGQJOW5Lz7hXBZQIik66kBi4PjVoDLT5bVDuw/coeKzAaibEVOLsXjxLlGfqCZX4AXRLxwaGyfdspxjCVQp5l6F+UOWGmPfcpMxcB69ZaRx0krMGIRSYYb+EfPaC0EXLPCxBaQSpUdLRtXefLEoh7lJZ/MTb0eUYq1oEAZWo5qbIYck1KI0R02K3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdYO6XRWqbqk7YvQFBtJlfkclYx+LVhFFb7WHNiN2Lk=;
 b=jNDqpo0Byk9rkclZW/f1tHo4HR5HQVYFWsKzJgMRgv4XksmeIV6JlE8ASAyUwyGOvAXrj4qqOvEnrreneTXkBeUR9BAfiHTU9XypvcXSgVUqF6JDMxzhznrQAJASYPmRC5Djk/TijwSv3aNij1g5pw6LtkYSbgXT26mUhkY6qx4fInmHc93MivYVtmjoVs+Zswfo5usA+rozSlyiV5q8T9QklC7F6n9BkKgUcBcO0OyWJbF+N5UH/GCJqrfZLlPHjkSAuGB5AMZOjDuUwH4tzbIxzr6f6yzu7fGgZJiwMhlhZ98eGs4FgT4gAZJdX1U1UuWjMcZXwCBh89G4+b5Yag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by BLAPR03MB5393.namprd03.prod.outlook.com (2603:10b6:208:291::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 02:15:14 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 02:15:13 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [PATCH 1/1] fpga: stratix10-soc: Add support for bitstream authentication
Date: Thu,  6 Nov 2025 10:12:56 +0800
Message-Id: <c30632bdeda6322dd3b5fbd39bc8c59912949ee6.1762253455.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1762253455.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1762253455.git.kuhanh.murugasen.krishnan@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:820:e::8) To SA2PR03MB5898.namprd03.prod.outlook.com
 (2603:10b6:806:11d::5)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|BLAPR03MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: b2311a6f-b9fd-4641-29f7-08de1cda4eff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpkJuiaNrowsPP/+0z33oPkbxsSBp1jVX1/Ngd8wgaCnTeAKiBQCMIJOPHnd?=
 =?us-ascii?Q?w+M4VRy/7u7uZW8+FK44xa6nR0lBf28hdApINbJPD9e5eCkrfK7E/TwnSJHc?=
 =?us-ascii?Q?BiSLjIq3k6Cx0BJL5IDOCeKCKUr3BG4kCi9JV8TyfVJ+dBF0NYnnvRKzWMf6?=
 =?us-ascii?Q?3HAVQ6DtYY6aJb6V1J8McQn2I6pHD+4YS13EIIwp5FiaPaHQZ5pgNsUcyCjb?=
 =?us-ascii?Q?l00qEYGAI6h1WFHi1egZhiHh/nmdjJrZW0FIMf//h+u++YbcpE56broWo36B?=
 =?us-ascii?Q?uaJlXw3XEN/HkhfmNdc/0I6NAy0Tr3oV4hQhb2zCTb8B5zct/hr5t9k/+YAD?=
 =?us-ascii?Q?dS6L+j5bDyJtiJqcBvI7lV4WeWO04qME9CF7nrGoVD8Bj+Fj3dobTZrVLq9N?=
 =?us-ascii?Q?+mrsNbQ+sRs1xczsMm8Y6ws+bpo+C2SJs2GQZ5imnhhUh1vDVbgXSAImzTrV?=
 =?us-ascii?Q?65ZRvOK5qjYGyo6NOD+2S107d4CQVppgNd6EMUXk5BVOynU8oZFbGb/42L5T?=
 =?us-ascii?Q?3lWJu8xkSOpxLZTQzQB9GFawyiPLJtZzni2UpJ1vaeJSCQ3lMnF+xdTAB7JZ?=
 =?us-ascii?Q?9UtCKNvX8yQP4UH3dCJ/VEeOQo2799ceKsE3vSL1bxYJOCiVQpUmf6yDlcIV?=
 =?us-ascii?Q?zcjnAe8U15t7q5K4ULQIHwxDgWHlZIinO+/Fe16+ljPbYnQJFnF18+rqzv5x?=
 =?us-ascii?Q?q8zjGdqpURNOR8A+szLW7OIo3r1GR1PQBSiFWDmYOf7z7vofi/cG/QvzvuAV?=
 =?us-ascii?Q?JiP/DiKjf5Ynazj+pydHvntaUSFxwNCyMLbv+DCwY0uZIhVPSBws/uQHjNW3?=
 =?us-ascii?Q?iYOWpzTCQg402YSZKau8SzXaDPXWFtyVf2dBGPs6ni3FdKL5paaAlRlo6VG4?=
 =?us-ascii?Q?lcarIr5HWDGlTG7l+mFniGFnExNbob5OuRkpNltt+DmKPtjk3nUUY+Diz0FM?=
 =?us-ascii?Q?dZliuIsp2RmhgldvMFTw7aYVhK9wsjeg76dCTm+uGMbU0F0luu5Fv/59DpeM?=
 =?us-ascii?Q?JjRfILWaR70H2SMg0f3w0mEFhBU6dKG8459gF6HFEGm10aFTVdLvgLfLSQqD?=
 =?us-ascii?Q?C8GCa2X49ZtahbkfnBmuMd79B96OE5O0HuUNslGE4GJJZ2uJyMJXHiZ4hyOB?=
 =?us-ascii?Q?sTncIpQh8y4Ks1jq9UKy84HpKyfYHMNGySttfWvTxbtYbtxE31DzRWX6ACZk?=
 =?us-ascii?Q?inIzRDiIGFxUGdt3WjQsgaNwLLfpII4iSJpfZgnccifWrSZdfl4Xpo4xRYzA?=
 =?us-ascii?Q?S1esYy5hA1w/fb9ehtFXHZBVoK4eyEpCg065/WxKaWrL+9ADpEektzEp1l1I?=
 =?us-ascii?Q?yoRqVjLDG13iy+rFxvD4g5/JabfiOK3zFO4cUSB5joR+0sr/Yc4indonGtq9?=
 =?us-ascii?Q?jCJiCHxUcZ83Ywgc4R/jVp8NTwXrLdeOqXbUrSh7JcByFupHqkTHpgPEEd30?=
 =?us-ascii?Q?yWBr9DtvTe63kZ9I2t/C23w8JuaTb73+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XGE+Ta7d9AUDTEY55CxWC1X8scqpCKOOqKUNsz+/wsqmupv8viC6Z+drG6J4?=
 =?us-ascii?Q?NceRjHR2/pMb3JPDA8AMZ3j3D0tRkaAlVtgNa3aXrWjSDpbFlZRQZXZPbbYj?=
 =?us-ascii?Q?Pi7a8cuXkXt1BwY/NBgsspj7PXmEWtWCCmC8+SfZC/V284TUDCqxBCXy+k//?=
 =?us-ascii?Q?eRjUWNcN+L8Q41n7NfLVfn2rElQSdZrJEXUMZi3CGfvlQJZiLqQjW9M43vtG?=
 =?us-ascii?Q?Muchmcnx4gcg7s6w1sGK1QIsPPZVTO5dQECRvoblVh929/xFe2pD22iLHvd9?=
 =?us-ascii?Q?bXkTdzsDcIoua2tqNFXEZSkaT20xkiSfUzCtzc7k5+zBDZLTHyaTjIu7rc3u?=
 =?us-ascii?Q?cnOOqQBdFMUiiiGYDvhUaL9+jgkrNpP9CnScs03VVSShQp1VpACmEFgE3uao?=
 =?us-ascii?Q?CcvawyjYp27yXlG3uzjJDBObHPZ0amvejCDq4LjEM0q7kh0W2bvqQjjG7zTF?=
 =?us-ascii?Q?Mrwlyw4kmOkniiVDSkqkY1ru06RvGfvCW6KdfZp09SN1x0udC0hS64FXKAZA?=
 =?us-ascii?Q?08RVPvkfLwry/biyXila+N31rcLsLeFFoZMBjdM3jdXl1VEJBA9pPKO8ixRM?=
 =?us-ascii?Q?L/i8jpfksTj7dqHgRU5DtiH8NUl3xHFtTDc/IxMX6MF0hx4o6W6YA9pHvZ1I?=
 =?us-ascii?Q?8MWtEDmknj0kSrOC+zgAe8nFLTq0GmYvkV1LiYKMvj1Rzr/J+EBdtOphqT93?=
 =?us-ascii?Q?2dyTeWc7/jQ12w4mbUXS1fjpYfBQm8lZWJEU3LJUwhdRtGZ0+qRlyt/XReF9?=
 =?us-ascii?Q?XJCBD3GZqapNZHKImLdn2jC12Yc+VuJqgER4cu0CivpaazezaMLtIvjnvv2M?=
 =?us-ascii?Q?6z40/adnTMS6yeshrUBjbXJmah9+TisuVrmvmt07IsTsWA5qiiyu5ityyuHB?=
 =?us-ascii?Q?pz0fmDCAuGZEQgbFyHnlNxyRbqIp59G+kb74Isgzw63BUwlhAd2Ut8ZNnK4X?=
 =?us-ascii?Q?fcFdzpcUvzHvLJIDclI7GgZZG+dfADzyWEy/ZNDCFA84bOOVFm0QfyNImaNT?=
 =?us-ascii?Q?lGtBPhzC2JzBANxZWY5rz5HOqXyraRUJBuTmKZURCoKFWYXj8VEOuTIQmy63?=
 =?us-ascii?Q?FUWU/xwkPi1e5voeBV3ahH38rFfdLudiCyMRqJhXo5RClqi24AWfm/iOcNaQ?=
 =?us-ascii?Q?5d4sHRuQ3hhFFWv7RGXXjwqjD6E+JeS0cBqWIBlKm8sxILHJ+XWjRa8N8m7U?=
 =?us-ascii?Q?TQyvfuqynBKzJbLkB2yQX7xkUZpLBiKLxXL6rqwGP1WhylA2SBvkPjAFMKCT?=
 =?us-ascii?Q?YyAw7iwXUog01yUrIWCVTD2g52aAjsyt+mJEwjhs6Ecgvxt5+0buYfJJPWMX?=
 =?us-ascii?Q?NIHkfY8YBLTZCBqwoQ3j6iG1OKVMXaSc9D1r1ouOTEaFt/iJtK8MyYriDC+M?=
 =?us-ascii?Q?YUCgXGTW2GpmGMPjeeV3DYjd8Qh8b/slkVc335d8Jj6tEK1hBP7fQbnqbkvE?=
 =?us-ascii?Q?AUpd6PGTTCG7Io8T48S6pE2EEcSMYbU38LAES3xgUOVxUInb1riYfitHzhl8?=
 =?us-ascii?Q?ovrFhvm2xVC+lZrv/UQcZeaUOVKPwJ8I86VqjVde3KVazo7Q0qV3Su9JWVgl?=
 =?us-ascii?Q?AYeKK4OG2BKA1VLQvMibAc8lGC+jZPThPOxqjq/bwkDPUv1CskPfIQh1OldB?=
 =?us-ascii?Q?EhWD3jr4TZ13gmN4xs4arfE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2311a6f-b9fd-4641-29f7-08de1cda4eff
X-MS-Exchange-CrossTenant-AuthSource: SA2PR03MB5898.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:15:13.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6TzMpckjpKegBGdMHi4msg6T1ddhK/yAa2/gWP35oaedHrBqKYkgSRy7NReRerBN8Uy2So9N7U9o4pqCEjEb9qAe5h3QJdkBLJavFQHmAz08Rm+YLNOOY3m9ON9TIf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5393

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

Extend the Stratix10 FPGA manager driver to support authenticated
bitstream loading on Intel SoC FPGA platforms.

Some firmware builds include secure boot and authentication capabilities
that verify bitstreams before configuration. This patch enables the
driver to request authentication by sending a dedicated command through
the service layer, using a new callback to query firmware version and
determine authentication support.

Specifically:
- Introduce a firmware version query and callback mechanism.
- Add a new COMMAND_AUTHENTICATE_BITSTREAM flag to request authentication.
- Update all service message send functions to accept a callback.
- Handle firmware that does not support authentication gracefully.

This ensures compatibility with both authenticated and non-authenticated
firmware images while maintaining backward compatibility with existing
reconfiguration flows.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
---
 drivers/fpga/stratix10-soc.c | 61 ++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..71661171fbab 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -25,6 +25,10 @@
 #define S10_BUFFER_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_BUFFER_TIMEOUT_MS))
 #define S10_RECONFIG_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_REQUEST_TIMEOUT_MS))
 
+#define INVALID_FIRMWARE_VERSION	0xFFFF
+typedef void (*s10_callback)(struct stratix10_svc_client *client,
+			     struct stratix10_svc_cb_data *data);
+
 /*
  * struct s10_svc_buf
  * buf:  virtual address of buf provided by service layer
@@ -41,11 +45,13 @@ struct s10_priv {
 	struct completion status_return_completion;
 	struct s10_svc_buf svc_bufs[NUM_SVC_BUFS];
 	unsigned long status;
+	unsigned int fw_version;
 };
 
 static int s10_svc_send_msg(struct s10_priv *priv,
 			    enum stratix10_svc_command_code command,
-			    void *payload, u32 payload_length)
+			    void *payload, u32 payload_length,
+			    s10_callback callback)
 {
 	struct stratix10_svc_chan *chan = priv->chan;
 	struct device *dev = priv->client.dev;
@@ -58,6 +64,7 @@ static int s10_svc_send_msg(struct s10_priv *priv,
 	msg.command = command;
 	msg.payload = payload;
 	msg.payload_length = payload_length;
+	priv->client.receive_cb = callback;
 
 	ret = stratix10_svc_send(chan, &msg);
 	dev_dbg(dev, "stratix10_svc_send returned status %d\n", ret);
@@ -134,6 +141,29 @@ static void s10_unlock_bufs(struct s10_priv *priv, void *kaddr)
 	WARN(1, "Unknown buffer returned from service layer %p\n", kaddr);
 }
 
+/*
+ * s10_fw_version_callback - callback for the version of running firmware
+ * @client: service layer client struct
+ * @data: message from service layer
+ */
+static void s10_fw_version_callback(struct stratix10_svc_client *client,
+				    struct stratix10_svc_cb_data *data)
+{
+	struct s10_priv *priv = client->priv;
+	unsigned int *version = (unsigned int *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK))
+		priv->fw_version = *version;
+	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev,
+			 "FW doesn't support bitstream authentication\n");
+	else
+		dev_err(client->dev, "Failed to get FW version %lu\n",
+			BIT(data->status));
+
+	complete(&priv->status_return_completion);
+}
+
 /*
  * s10_receive_callback - callback for service layer to use to provide client
  * (this driver) messages received through the mailbox.
@@ -187,13 +217,22 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
 		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+	} else if (info->flags & FPGA_MGR_BITSTREAM_AUTHENTICATE) {
+		if (priv->fw_version == INVALID_FIRMWARE_VERSION) {
+			dev_err(dev, "FW doesn't support\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(dev, "Requesting bitstream authentication.\n");
+		ctype.flags |= BIT(COMMAND_AUTHENTICATE_BITSTREAM);
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
 	}
 
 	reinit_completion(&priv->status_return_completion);
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
-			       &ctype, sizeof(ctype));
+			       &ctype, sizeof(ctype),
+			       s10_receive_callback);
 	if (ret < 0)
 		goto init_done;
 
@@ -260,7 +299,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
 	svc_buf = priv->svc_bufs[i].buf;
 	memcpy(svc_buf, buf, xfer_sz);
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
-			       svc_buf, xfer_sz);
+			       svc_buf, xfer_sz, s10_receive_callback);
 	if (ret < 0) {
 		dev_err(dev,
 			"Error while sending data to service layer (%d)", ret);
@@ -304,7 +343,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 
 			ret = s10_svc_send_msg(
 				priv, COMMAND_RECONFIG_DATA_CLAIM,
-				NULL, 0);
+				NULL, 0, s10_receive_callback);
 			if (ret < 0)
 				break;
 		}
@@ -358,7 +397,8 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	do {
 		reinit_completion(&priv->status_return_completion);
 
-		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS, NULL, 0);
+		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS,
+				       NULL, 0, s10_receive_callback);
 		if (ret < 0)
 			break;
 
@@ -406,8 +446,9 @@ static int s10_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->fw_version = INVALID_FIRMWARE_VERSION;
 	priv->client.dev = dev;
-	priv->client.receive_cb = s10_receive_callback;
+	priv->client.receive_cb = NULL;
 	priv->client.priv = priv;
 
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -428,6 +469,14 @@ static int s10_probe(struct platform_device *pdev)
 		goto probe_err;
 	}
 
+	/* get the running firmware version */
+	ret = s10_svc_send_msg(priv, COMMAND_FIRMWARE_VERSION,
+			       NULL, 0, s10_fw_version_callback);
+	if (ret) {
+		dev_err(dev, "couldn't get firmware version\n");
+		goto probe_err;
+	}
+
 	platform_set_drvdata(pdev, mgr);
 	return 0;
 
-- 
2.25.1


