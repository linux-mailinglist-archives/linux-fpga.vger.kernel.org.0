Return-Path: <linux-fpga+bounces-1405-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8909C2EEBC
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0367B189562F
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 02:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB023C4E0;
	Tue,  4 Nov 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="W4dI2GUC"
X-Original-To: linux-fpga@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4923A99E;
	Tue,  4 Nov 2025 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222303; cv=fail; b=n6kNEtVyvLyl8+3lydmfClHUoqUuW7nJ9THyce0Bge5Yce8BEEic+5gi0LKPnCEyUu3CxV3IqgsgOi+qbAgbraDD23mTtANwjxI7ueODOrerXgJkpBZyPn3GxQ6D09iZUna0dCCIlmkhsZ+RQfl2I4IlYVHkow4cn/a55jJLZl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222303; c=relaxed/simple;
	bh=ad4WrwWi0suXgQzVXd95hOrpe8ri/67hcmrpwEEa/Jg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j04/6g37w3sjTLqMVAYZv3IW0z5i9YzBmnIK1m7usNGBH8j4c9K/MS7R6Qq6LX9nubgIFhmPSMzumRuj/FUl5s+DGLXzVH1JZC71rYGOBhPwyTKCiP2jj/1VvC71+OYRjGElncm9e/xG5hXoT/N9y14jQyTMNvHZNiUk+F3VKiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=W4dI2GUC; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOG3Q9YdDxA+LO7mpRijOHPVPmYLCbiVvzV+7a4mWqo1QMLS5kirGs/0wVUYAhs8XzxE6TtCikBELBwk6u6dX9c+63f+XsFnK6N7GCThokwi2e6nhc3bFPVo15rgYnSXPw6+ImFZdJOA3APMHKKwk0RGSq6BuQ0jVE+xkZXzRIFaTE5AttdVX1GGvyY+KIDBxg7FEZrlL+8rZ+xMw8yimXoxyLjT60B7JCjCHlZbzToKQt1nsgj+MXGXLAtbD6k6zdXgqJxVJ9WZge9lr3D/1GYRc/QeYh5ZVzS1gvtivcx3ImkDRmr2Gw9mWhmXxTgSzZcd3OxmyPy3owvvpkUvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQUPeS/A81OELXHGu2q72bGCyaW4WDTegt6WbRMZ5Qs=;
 b=jcXvJzL3n3mpNcCUJzUTYjL7AdTE3eFvrE+32C912TVA+DB6M920phfoXtU21f/AvhzA4AAmEizveiAf1CG70bJZqeMisJP8fxATmda1m2IrCxgG3043uNzx5/Y9FDHzWrX4bDBStjcd+eLR22/00BMbC2A/74yYbICKG41wYxigGnA866OQmq33qDp4ehRrYj1oV4T9V81KcNy+X2CwTJpaWxpcuZ0rl5LxIlFk5KqHVpBNJuTeUxsOCFzhjRFaC/J9HUgY/sQB0rZkfG85Q8MBfLMMWDt6fkrR/cBbmtknIsUn1vYVqkdAA5l4y56y0AeJQntwHC3wZ0ZmNSuQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQUPeS/A81OELXHGu2q72bGCyaW4WDTegt6WbRMZ5Qs=;
 b=W4dI2GUCjgi+Dvdl3p33WFowmXYYhgpRpVMw24o5DK9QvumXwWIGUKWlU9R+vMPYk1dGolU4Vw+5rZnd/HMqDj4rEtMBMI5Z60BC63xKroLN9WMcU3czZL0Thfk8+W2HDJe3j0N19XXLCJYNeoCZ/s+94uKIQ+CvhqcxQrowbPAgSl+N0VxaiMFe/6PvjsS1/7joyy5VA0EcEg/sU8nwbaSPEnGWyU3SRxOPB1Rk6LtXYjMWOek8yfDAG0NuBTh2bJowhDC/cprCeprCer8lRpRHqOCvqOL5LEuqiX346oqQTSHCAy06h0lO9kDT/x7lBYPJEXz0YS2flD//DsRx0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by DS2PR03MB8369.namprd03.prod.outlook.com (2603:10b6:8:331::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 02:11:38 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 02:11:38 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [PATCH 1/1] fpga: altera-cvp: Add recovery retry mechanism for teardown failures
Date: Tue,  4 Nov 2025 10:09:27 +0800
Message-Id: <0cc551b72dadada1f6c98881dc5cbdd535aade29.1761704862.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1761704862.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1761704862.git.kuhanh.murugasen.krishnan@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To PH0PR03MB5893.namprd03.prod.outlook.com
 (2603:10b6:510:32::6)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|DS2PR03MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: d74c9665-fde6-4d5d-e50f-08de1b477c9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KvzF6Y0dkRwTmlptoHZu5b/eHZuhCkMdzDBroQP25k/m6sC4/UdyXMT04aAL?=
 =?us-ascii?Q?NomXmI3fFsx+rtf39AqOchoL1uAYYo5HmhruP7rQt+nZE0+x67IKKhkmIWH2?=
 =?us-ascii?Q?71GXOYdUMeXaw3qMdxpNskXF+XaPMWoeGAkqJ37gB6cJU1Piawt6FbPcgzMM?=
 =?us-ascii?Q?bnzRYV2+28uUweQMRAD6Seh6fBdpotxj2zmv0BkmnwTWnqpAYT+v9i4pXV51?=
 =?us-ascii?Q?Ur0C5STVfDcBMwjaudisVkikL3FIfdkVXMCWocb/LZP9WXcCWRqBbHU5QTt6?=
 =?us-ascii?Q?tdoiarO+mDPEXB27GyLn5OimF4iUfnigSEo9PczXRlbpqj1yq9gnNiRL4sVV?=
 =?us-ascii?Q?JPoJlzdAkYrER33QGDmW47PKjlJn92ZYCg7E4vQXLeuj3HR32l6xzA3/WZPb?=
 =?us-ascii?Q?qRfc1JNsPr5qcg0HK/TQJD83m+Md5HeLfXllvhqAkiaKDBuuMZsl3mGp7bQn?=
 =?us-ascii?Q?0Pbs7v3GkvYPYeXb/HCpXzPZE5yFCYemaeAVOZOwSZXb5F7PYu1DGqCSPvfC?=
 =?us-ascii?Q?mtGPlcjn4fr/3+C9ddMAvtScUAKWhhV34l+zQPNWyfJl0Ayl33qc22uuA5z6?=
 =?us-ascii?Q?VlNQZ2fN837/p2mUMP8OweN/lwxakRS7CzfyVDcAbFZ0DetmmSpwm6CuX/Rq?=
 =?us-ascii?Q?tMlPW8Ijb+m4OYZ2YLx3Vy+IYb0W4FotTeGkrtZdMKYZjBofV/2yabjugTvU?=
 =?us-ascii?Q?7l20El8Xv/f/JRFF2NVfXyCJ3iwS1wekUqCDXpIMURUSvGFDY42a8cvUyUHT?=
 =?us-ascii?Q?/SE6mnMu1DsRrHCnmzvu0V2rfpIaCUNwb9KsKH8PMZOZBDu/nOqLg+Nu5sX8?=
 =?us-ascii?Q?SHfTp87aM4i6daRQaNLKXK358MSO1DlDAOhNbByawTo8LO/Pakk+62JIOp6s?=
 =?us-ascii?Q?/gWpXyEkZhBhaAfhWJKrqxplYkWg4xgbJldTZsjBkuf2MQ6MtZzUrUcXyJPi?=
 =?us-ascii?Q?TxkpXXGEacHWwpXghHB1QyDRaxkKqjqLjuNLtnJyykaF9uFo1UIWMMBohLl2?=
 =?us-ascii?Q?q3kxhNw4b05rVc8FZl5HlkTDHiPsZ9d1aiwfFAux/jB7TPJfFnwZp74zmUI6?=
 =?us-ascii?Q?GfP1j/iq5wQAuz/8v5RnyO+BJ9OMtvGy+kCeDOgJpahK1FhoKvHN5R4tb3vJ?=
 =?us-ascii?Q?qZVszVQsO+qydaafN6ULnMr73E8RYS1eNGAveHHKYf5Ta9Z72VHWtiSLPWtm?=
 =?us-ascii?Q?PCqO2kK51FQMIwBWwhRjrJUACPvr1hMD8j+dF4KEkz8C4xhEWqBcNtJoXUl1?=
 =?us-ascii?Q?EgazOjwbEzXpQ5wi/xlCqBvg86PYwvlVqv8ZQJuVdk+dArQvxWoTZ14zvE4Q?=
 =?us-ascii?Q?Jfr92Gg7/E9snUZq8/TCi0ddH7sAA71duRnzHGZA8qNWkROA1LrFpY7dPJqk?=
 =?us-ascii?Q?YznBS9ElNYFst1ZMatlRreU5lEe/BYgcHXjFOX/WkZ6lB+m+ud0UFWEiaSiZ?=
 =?us-ascii?Q?QZZgG8gXLYl4QK1XY/dZMUoeiCgvEa65?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yRhlyZmR8rZpXxciYeP3Gu+j+I+RmptS70y7lbxdUwbPCVhEd6xnbHvStIK?=
 =?us-ascii?Q?fgAuTiU1CBMisg0DQnlfHBwHVbSuS++yNTygRB6Z45uV8FvbogMjNK+RGFsS?=
 =?us-ascii?Q?9fJD6BMbk7PEPEhgG41RzmMN4AE2Kr6jY2JPKqjWeASkQGzs9oT102BcjugU?=
 =?us-ascii?Q?+GCk2vEqPYtxamlESHR/o4eFJWzYjus4Ltj7GjuiwQ0ECKv5vEL6duI2nMOY?=
 =?us-ascii?Q?Wls761T0JSBmSb+4xt0tq2B0AC1VH2wMNTclzSuTPvDBER0v1c3l7mzM/SaM?=
 =?us-ascii?Q?1yhIikALno+vc2K3QDVxbH7w6+l8B5JLFk4mE2l/wPz0dLajH88sR4M6s7Mn?=
 =?us-ascii?Q?jaLnlD149WprPIDFTsdH1XXnglSDrBbhzH9KPnX2qEMiHHQCSUcYNx11W0zC?=
 =?us-ascii?Q?rCmRiVGldRaUGWD/UgOAjtEE5XiO7jSK4a9ybh9ThismzGg09f1QmhPE+p9p?=
 =?us-ascii?Q?V14XFguWkgr2a6oFIQAPH09GSUNB3H4REGADSnK1AvgPv6l1wbq6JFXxZvnS?=
 =?us-ascii?Q?XxuTin+pPY+PtHiLgvBvVPHCgorP7UOQn2UYxJMBSzVy6yh/tH6KF/v97VAC?=
 =?us-ascii?Q?epKB/G01WnVDM5OkVNTRxUyGtSa5WRxOrmChrp1nlW7RxBwOfHYA3R1RgVom?=
 =?us-ascii?Q?oDCbaReQg+cwZW0k2r9TTTRagysCwFhL7VGW0/H8QzMVWsWwC/ycbis9Of63?=
 =?us-ascii?Q?rD4U6MMqE9EqjPmUlZVRcNiJmbnifFXMNOJg79rRYCTQvPWwhqRgzqr/FjUO?=
 =?us-ascii?Q?595Vk9GOLbuzQl0kMfQVimb4LZb7FZA4Q1PCbwbk/S4/5aEuXc1VFALOJScv?=
 =?us-ascii?Q?EoMWxdnCCvw/3uW/F4SunPuZ32RJy2DuqdY/+QdVg5+SBeeU6yTOV6bHbG9N?=
 =?us-ascii?Q?ke07AVAmOss9I9nEeEAWI7rc51xdUNybSg6TOUcCblmqFYbWOsQKAmlDdw03?=
 =?us-ascii?Q?fcRxEQZ5KymKcpGb8JtIyMQRk/XNsQTuZ687gZ79GfSHo2e30YCcns+ypNd4?=
 =?us-ascii?Q?EBU7C1wVdISsNQA23QNoAcSv/nUJN9SFDurT5jMev2g23vX1xvvFCE5Fvexg?=
 =?us-ascii?Q?4JBqpHW2LBJw5U8LuXg0Q3c3WR7rwPPVz0VGlwKhRKqVkmKZ9GMo8NfHQzsp?=
 =?us-ascii?Q?2IWxxlXHM/IgiGwhFHTHjMNOBmJ6t+EUoudmN3vBHXReaW5Yl6donSjA3TJa?=
 =?us-ascii?Q?QHypj1Yp/UkmO1XJcGqloqdLeZpQ+Fq9cibzrgbIXibR6jqAD5B1gIXbLnJm?=
 =?us-ascii?Q?P5GEOjuc77L4W25WieYU9K8JcICjExiHZ4zopYIY6jFEeIJEIhaq4dmFbZ6V?=
 =?us-ascii?Q?5GEnJGdN8mfjCic68PFI7J8Cmiyric+EZLz4GPjIPT/nQe14tlxxobq2MgEK?=
 =?us-ascii?Q?ocDyaf7Q7+0usIRXlpcan+e7CwHnDsIQjKZIR3gb6qD7tkQP146K71WzJk73?=
 =?us-ascii?Q?tsN1IyDJ0U/yjNm5OjUGBzCq0WkSSG2sA/2Z8Gatu3YG3mHEq887d9Zp5aPh?=
 =?us-ascii?Q?qK9f7D4ok/uArEW1uZs5sjrUnkFbIj3PRgSfm6FxFZR8vzC4jXr/kQI6FCrh?=
 =?us-ascii?Q?jJdTlsifdSEQmttkD+UQ7TWqJTJAx0Dpg4guRzA5fwcXhqgfF4DBY3tQ8uMq?=
 =?us-ascii?Q?+GKAXlSRHSPA/6+ECxs0AaQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c9665-fde6-4d5d-e50f-08de1b477c9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 02:11:38.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul6IcQf3cQfic3u/ocmqizD4Y+ZYYNcei9G/mmeva9v3RrqdjF1AQmTOsW6tdAAR9hio80dG+6AoaTopf1wGvNDjS1bBPvnMJqyYNwRKS/PmMMZWnK3TL/ttHzMtWDwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8369

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

When an incorrect bitstream is sent during configuration, the teardown
sequence may fail and leave the CVP hardware in an undefined or
unrecoverable state. This prevents subsequent configuration attempts
from succeeding without a full PCIe reset.

To improve reliability, introduce a recovery mechanism that retries
the teardown operation up to 10 times. Each teardown failure triggers
a cleanup sequence that resets the CVP_MODE_CTRL register by clearing
the CVP_MODE and HIP_CLK_SEL bits before retrying. This ensures the
hardware is returned to a known idle state between attempts.

A new macro, CVP_TEARDOWN_MAX_RETRY, defines the maximum number of
teardown retry attempts. The recovery routine is integrated into both
the write initialization and completion paths to ensure consistent
error handling and improved robustness across configuration cycles.

This change prevents the driver from remaining in an unrecoverable
state and enables safe retry attempts without requiring a full PCIe
re-enumeration.

Signed-off-by: Ang Tien Sung <tien.sung.ang@altera.com>
Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>

---
 drivers/fpga/altera-cvp.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..5c4f4a5bae76 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -66,6 +66,8 @@
 #define ALTERA_CVP_V1_SIZE	4
 #define ALTERA_CVP_V2_SIZE	4096
 
+/* Tear-down retry */
+#define CVP_TEARDOWN_MAX_RETRY 10
 /* Optional CvP config error status check for debugging */
 static bool altera_cvp_chkcfg;
 
@@ -308,12 +310,34 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
 				     conf->priv->poll_time_us);
-	if (ret)
+	if (ret) {
 		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
+		/* reset CVP_MODE and HIP_CLK_SEL bit */
+		altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+		val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
+		val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
+		altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
+		return -EAGAIN;
+	}
 	return ret;
 }
 
+static int altera_cvp_recovery(struct fpga_manager *mgr,
+			       struct fpga_image_info *info)
+{
+	int ret, retry;
+
+	for (retry = 0; retry < CVP_TEARDOWN_MAX_RETRY; retry++) {
+		ret = altera_cvp_teardown(mgr, info);
+		if (!ret)
+			break;
+		dev_warn(&mgr->dev,
+			 "%s: [%d] Tear-down failed. Retrying\n",
+			  __func__, retry);
+	}
+	return ret;
+}
 static int altera_cvp_write_init(struct fpga_manager *mgr,
 				 struct fpga_image_info *info,
 				 const char *buf, size_t count)
@@ -346,7 +370,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 
 	if (val & VSE_CVP_STATUS_CFG_RDY) {
 		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
-		ret = altera_cvp_teardown(mgr, info);
+		ret = altera_cvp_recovery(mgr, info);
 		if (ret)
 			return ret;
 	}
@@ -487,7 +511,7 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	u32 mask, val;
 	int ret;
 
-	ret = altera_cvp_teardown(mgr, info);
+	ret = altera_cvp_recovery(mgr, info);
 	if (ret)
 		return ret;
 
-- 
2.25.1


