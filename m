Return-Path: <linux-fpga+bounces-1447-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BDEC55AF1
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 05:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A64353477A2
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898A2FF641;
	Thu, 13 Nov 2025 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EVN8z04D"
X-Original-To: linux-fpga@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA542FD1D7;
	Thu, 13 Nov 2025 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009064; cv=fail; b=LsvRXSgBGJNjvtYi/kU6vCw3KS3WITD25jL1e3emOSFPm5UfK37pxnxE1hmEA+DRAsG1sHBSgY/5zSzxHhJQyCKimeVK0oQWHo2hyaKsD/i8mQHyOPBEguhDCBTWobD18c/wWPo1aOy0TojzUAmoVv/t0kQYn9T7/JM0doN6hzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009064; c=relaxed/simple;
	bh=f/3yZssKSfxh/AlZMpxLzC725a8vHHX6PV2Pxw8MUlw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+FZpOcWA7yE552riF1VemzUrsTf86kyBZBIe89gGbSehaSnEE7DIluVnFBnNsyIG7bfnteYqZmKsbz+mb59sVxx7cEc5ZmM9kD8RtGAuGIvHmY37/w0ytVa6lgFkzi/XWFYYcffWJ1jQr1wVURKOASIPCst4TKmrQ2T4dnkbY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EVN8z04D; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=susI3tJJWViJAEBpT7Kefzo68RsiNsFzmqsbJrR0ZX00TDjPH8ipqMj41iAhCpxcQ5v9JQgfSH748ZOeUKBG7hx80hLwjLcQd8NW47/YtJzHflvUVbGoekVQMisEl9DZt9vWpVmQ367btEBSNQkp0+URVGLhI+5HdO8Z+Z+C/DGewejSATbNlPk2Jhm7b1D74r4VU4cyXMF6w1NYlmEDiL80nhU74RHCSjhrBJMEewpK12HtMtNV+r1rSLKrhNMSxn4an/fTcUh0pPq9qCq/7UP5cF8rtr481ON8UC6Y9PlhIHwDfWtjlVmChWMSsFu9T07hW/DgcovcivFVNlh+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0XLrbsJyB/H5phgDk2vVsQwvTfcCpJsQF33HMFhAlk=;
 b=fwNXm2lmtuQc6xNqSoYV/J2rnkT8WBqTPYGXLqoiB4dvSbYSR5uKyyuJffYYc0e0yYNgkGIRXg4yJw6IragkreT6xwQBydtZGWhPZCOIKyYxg8aq5NCa/qIFsBhA+Bg2oEF201Qs/kcn0/FU54bDN9FPMpw9SIGlL4AVHwIwigRPwCIOO8l7NP6/Bq5tp9qH1pCYYNygjrn4pVnJJRDw21/hfforpr0Oprnndq74erYUOhaDYQQ/DMb5vZpMDnt9FBAFjsEk5W+hpClyCDSZqG21539hpllMR75L7iznRwKqbagBXsNlfWzXdupwebuZ2e/jGgIJHLxTfUZ0sHpedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0XLrbsJyB/H5phgDk2vVsQwvTfcCpJsQF33HMFhAlk=;
 b=EVN8z04DqB9DhS6AavWGAo76ZPJz7FdbW+ACnrplokz9w2VDP1j5JlWWP2GZo5xWv9Ol7CpDoNERmzLMZ1ybMA7JYcCbQznxJf/WxICAODpW/E8iTVQqaY3QHM1MPpj5wJ6bVIb0KAjLePlxUFEjP18GTzlzoylYbXwzIwYev7xERf7riZLbeb+KCtl9XJDDL9NyJK/1Ac6GpghPKZXy9Yvz11Z3RDlX+9ciJCb6vQRLd3p/H27puFc2yQ7XEg9vbV1JIoS6HNXE6UE/hEwcGCqdnetT/Mqpz6cwDD0nBxchNriSi/eMFPzC99r0rjKA9B7S0qULHjoSLRvRYv3tDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH7PR03MB6862.namprd03.prod.outlook.com (2603:10b6:510:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 04:44:18 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 04:44:18 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Thu, 13 Nov 2025 12:43:55 +0800
Message-ID: <e342dc1626ae07d6b1773ad9fa5232d38af76bc2.1763008269.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763008269.git.khairul.anuar.romli@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7fcb64b-e25e-494c-2454-08de226f4e45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KNhl9ps3JXZIh93S7qX5bYTBY5lz5GTfZEC6eghgP18F2WPkY1ZkGDJW7NA?=
 =?us-ascii?Q?8ttLNu0BoZXJwg3yI05haJlUlwaX5Ll9iTJXgW7dKfKlIEwWC2WwbH3yjsXw?=
 =?us-ascii?Q?mqZvNnZSu5cp8xaczwZnPonzdpbG5Jjl7Cl+3YX9/cXhlXX4047aLWd7PtSd?=
 =?us-ascii?Q?o3309a5P7D0nPkxrDC2h4zKnn7GEFz4JJT4U7RCnktFxWw717HNfYpjSphFN?=
 =?us-ascii?Q?XungDSmdWNZhMxIvg4jJFw1016qVmmjfD9zkypMOj5R1y87rqcb8uAwTWJya?=
 =?us-ascii?Q?8HX5QMF2Nqqb7meeua9Y8reo8OtheY5KvmVk+eLGGi2wWUYiXhtJoosukr39?=
 =?us-ascii?Q?SQC9X5KpnM4SzZaG+vwMcGm5D1uwj1ZRCdUpYo6YDPaufWn/gpyzWEfHxpY+?=
 =?us-ascii?Q?xUwgEC6g9Zgk7IlhvdKFEHVI1OrFRln0+yraT1JdWGFsHA6lywLuafn+glB+?=
 =?us-ascii?Q?WXpWmY3MlPwODYxCcHnNECe5KGrC+DOE/7oz2uWvwnCUMWhzcGQvQMmxzIyw?=
 =?us-ascii?Q?WAlF/CPf4xwAclbAxHWGFcwiMu3VC70MtxJ0WmqMwCPjZ5FtA87w25jZfIBl?=
 =?us-ascii?Q?lEnrUfwSoyvGELc3ZK8zil1wPJwj+Tr2NSzIGWyK1G0RjmW+Ql54yKzcpDTM?=
 =?us-ascii?Q?c4e710IPb9JxcrlgP+gUtb0HgERxc3o/wmb+4guTxzTU9sszzMuIzQ7bBaR0?=
 =?us-ascii?Q?BcBf6K1sNOsHXZdPctWjaTVpzFlgP5iJy9vCdwC2sP5evuqgHKJu0d7hAFUE?=
 =?us-ascii?Q?OVG+KCZihP7SSOIcacr2Gr55ClchV7i4RiawuAbo/6FQDTDvov0xaKL5aTr6?=
 =?us-ascii?Q?NS0YHFNCP/bU4E2PGb2ZaNf6Lze7DgvKkaaVoAB5el5HxF/Zx+scc9g6UhFa?=
 =?us-ascii?Q?f6R3ItNWxKfEpR69c/mPomSSt2qAuKYXCgBbym0HqZetEE1ZuOxfW979vhrm?=
 =?us-ascii?Q?38Ii+hJwMMyghIvu55DNhOwizd7EGKdYSHywfviY+pao80jVB1DUYz0Cxgdy?=
 =?us-ascii?Q?s3mvpFUVUX2j3IPFs+Xs6AateDlMZL7uxL/ppxIdU6hrW+gwEGNXBhoNtJqE?=
 =?us-ascii?Q?MgHaPSTFPubTBKKRUqEkqeIl8+1APN7B10iBFLWcEQG/XXafn/OSHEmPE7xA?=
 =?us-ascii?Q?5/O6gxCUceVg6oBoUnlzYWMcrsUt1+NPE2T9aeXnztPF7qZ3aTx6VjiYNVbU?=
 =?us-ascii?Q?kAsNxcXIgt7XtXSXM4r5ikkkv+sJg8dpBLoKR1toaiv1gSYMVNDXIttjuGq2?=
 =?us-ascii?Q?sV//2pPk93PZrxk/11TsgsHX0ih1ZgD6iLntYjGPMNSVStNkM4M6V4164Ina?=
 =?us-ascii?Q?SDGRDdf+iP83ekO0AK0VnmCVAT+ElouPHCtAehCzFnig5EiOuTKN/JsmIRwE?=
 =?us-ascii?Q?emMrhT4ItyyGG/iZNburWBRn9AAoWyoFIeq+Se1RlP9ZVijCBWQLLru/prVV?=
 =?us-ascii?Q?5Ps5LfwEOc1b3a/YGYGY1P5BdEbzf0gj9iqCa1Xd+zTszeWe+x17hWf8vWHa?=
 =?us-ascii?Q?fsUBkwU/Fpxqm/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kRFRzkc8zwH6d8zjFnEXY9fDQOgqOF3dGiAPR7tVwQQwUMRdq+KPNSIssqs?=
 =?us-ascii?Q?31s0Qn2U7sWaCV468li1l323jXrkI7BEtZROGjSN9Y4VKrCo1CDa9KAEcawU?=
 =?us-ascii?Q?OzhXoBEhDp1QOJfmC00xVjz0dCiS0CRUyc80Z77d18BPgSt1oAv+5+tZ7izg?=
 =?us-ascii?Q?nbfkodXhbGelE5hzMx9RjfALWRPTb7LMLKizJmkkYiyv5vsNu1Xhfot45wP+?=
 =?us-ascii?Q?zylh7BPLm/OFwy6Fz06j8SXasVLn2WtopDOIP0ivmhR25PaqmYKqLdJzHoBs?=
 =?us-ascii?Q?W0U+kaJG0PQ2nSO1LA2WNG8uraMiVfwNhVZuLzKteL+4rWVAK8JFylBRCJRS?=
 =?us-ascii?Q?YJPWHYtgOZWPm588eztPfJx2AuHSjugm9zDbXP8VH4/5Aa6hFTbx/7xIX3wZ?=
 =?us-ascii?Q?Bo16POVT5/p3n4Vr1qfoRVv1liJV3T98j3iq4L0dI3dXoODctTF6Vkqs3lxp?=
 =?us-ascii?Q?zEXm+XltLGQjdpg/Ksyqf+DuJLcct+z50CCcaDHinOkoPg4FvIBA5mEwxxe9?=
 =?us-ascii?Q?Fu6CeLsV1C6r4n835tlu0j+AQmzPRCnIPrH6z1EpvJaXA47DWLIksu/8fXRg?=
 =?us-ascii?Q?Nm6xZhuY1W7YpDpNT/Q0SoRIkJgqDbL4fw9Y6Nnj9+LPeixwoUSX7fRYyeTA?=
 =?us-ascii?Q?2pY15CsGKEyr4J9xJIoPz0IFa9sIU0zMkQHBlc2YFOQFRL+/BoXZQWy7HV1p?=
 =?us-ascii?Q?XwZsRqWFj0A7EOwrx72dOXkJFYlevfad0WQdMGyOME9L0QSgrUErdWA3IzD0?=
 =?us-ascii?Q?ESEIxMRDPUc5HU+m8bz4mJT3tyuukE2pWjyJhC3BBchqUsmHjabNewYXcYCj?=
 =?us-ascii?Q?DyLIaWTjBQJpuH/tK4vPG1cn6q0rXd6gplQkKwAEdPFJZNqQOtH4Zd5KAe4z?=
 =?us-ascii?Q?MdYu4GBE65Y7dFltG1YrJ3emZIpskP7stkNPlBScBdj8yETCETxKm0/DYqPr?=
 =?us-ascii?Q?pKJJY6bdZYsjpvAEcosR67n1VXbSm57IrWM0PXwzDwNLzLs13EqTOT/lWZG0?=
 =?us-ascii?Q?Z5tTuxvw5cMW6J0BWCpWF3UBRGq+G0bhAQ7d/3YPU5hRYy4z9CvwVM9cq41K?=
 =?us-ascii?Q?IFhjPMVyboyNRQtBWZugt2Fl1sGLW3C8Zq/5z5rXLMPy4w8jM0tBcif72MC0?=
 =?us-ascii?Q?RvUSN0iIXNK1frFAsxPnnd4CS8qN8967I1Di6uE0oQwSCShgn+6vtbB9p7Ey?=
 =?us-ascii?Q?ejdliurB7laf38WK5GH0FXZDei89D7kWP9mQIquZ8lGgSgEPla2AGNLOmc6E?=
 =?us-ascii?Q?Govx7U4FZKuBOekWTX/LhB0eM/Fv9ncKxDgXkN+YOctjxhSFST+uKhgO6jkq?=
 =?us-ascii?Q?kANnMLrOq2IzU9hDgEfb83XkuIlN6T75n5QrYttYw2OiJ3IR/DFzvGK7wkyB?=
 =?us-ascii?Q?xU+0UW4+prFUrFGcH3ybueDWcqop8jDtj8NdO9anrbjbyUKPHf/W20/5Yv1j?=
 =?us-ascii?Q?iiOy1MsvkVFriEBG1cBKAURkpUe1VUql8rwAww9BZSIX5wu93D+RFiG5tsJ9?=
 =?us-ascii?Q?tEwz9SnGkWNNDmj4Jjth1gY67n4AapBjUsODEi1VavHMRtXhWmktZVvon66V?=
 =?us-ascii?Q?K6ky80tr9inCdEjMuaLPZw7+0DkYIaeOEtiaUsvL817EcsjT5WuojhDfI7Oy?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fcb64b-e25e-494c-2454-08de226f4e45
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:44:18.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHGvosBVNpNEl9Ucft/RszVcz2rRlyuwvIkPQmf9io0aJs7Ww1C5BWMYXFNk9rOxymmHLNGK3GR0M6uj5F0dTf8SzJkepVkafau+ol9Iefc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6862

The Agilex 5 SoC FPGA manager introduces updated hardware features and
register maps that require explicit binding support to enable correct
initialization and control through the FPGA manager subsystem.

It allows FPGA manager drivers detect and configure Agilex 5 FPGA managers
properly. This changes also keep device tree bindings up to date with
hardware platforms changes.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- No changes in this patch
---
 .../devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
index 6e536d6b28a9..b531522cca07 100644
--- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - intel,stratix10-soc-fpga-mgr
       - intel,agilex-soc-fpga-mgr
+      - intel,agilex5-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7


