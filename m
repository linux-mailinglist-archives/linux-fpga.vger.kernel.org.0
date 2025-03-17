Return-Path: <linux-fpga+bounces-1123-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9349A661BB
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 23:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232A1172822
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5821FFC55;
	Mon, 17 Mar 2025 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wyoPz4JP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB029CE8;
	Mon, 17 Mar 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250898; cv=fail; b=Y0co42Qv+g1iYSmhTpiofJj5Fa3sUR1VqjUGQvUxwl3fduzveXAmoboEKWqcN596N6YUBGNZZTxt7p/TMLerkPTg826tj6dbtw+jBkc/kCP1RniFOtDpWenBA25ynt1eD9FrvXvEYM9U0YYCASjnCEyn5qJwuABYJ2BD+MhWK8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250898; c=relaxed/simple;
	bh=6AAZwURMFgwG9oI6JxxNgoiu+UvJ4qySnxkHMK4iC4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WkFP2mnX2WeyoRoJ0NS8oMl/YE9JMFjWsj6eKAdMmKQAJkRDcHuCFIVGhUAdrFu7P8gmB8APQHpfdvJzPRejTAyFfrwLwqhXypb+Nk2OLpwovuv18YZQJ36UXjX9L70pt8WfpspZ1lCPaWtJihTVEeNLx8WbnQ14T4Lsu4Fbz0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wyoPz4JP; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqvvPf7ZnZOQiB6Yzqdq491o8J+keBYjEwegAtU9/jOcPVqhLFoVYZYEQnNsgoFysh7S9EBQaYcf8fIiSrJq4/CWW5WZtuGE4Oh8pLxm3ZOWI139MiQgAFCXrWpwNVjJsimWv8qGlF3T7F/AS1sU0dPJE8L7SFL2V/mYVhLg1JpKgbQUia4vO4TSfsyKamFoDFiR0PnTmyeW/gf2UslmJv9Uo6kjpv335qFsYupQ1O6/nCimrhLwACknvFr5LY67pVVR9WwFL3oEZlaQ2JyCbb9Ng2UWaXxIJSV703PFDX8LISQH4YSf+9MK0hBKTeCl3SvDBn+sBpwGoxU+OKesEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7ZXO0X3++86ELs/gaJ4Kzq5+T2fD1qfY8HK5nO9StI=;
 b=nfaU7PoqnCN/Hc550OIXZ5mqEvyaY0SPRSv1KDqXc0G8l6x5OlG5Z9lhuQmavTrORYyAQ5jESrAqep1ExTHybQ6Kv+9xh6HmHjLCLA87lidB5qgyegW+AE3+f1YQmIRALUcK5QD94rQhbfy01rt3Fa4tfaa2qcf/LFoonw2FuHUnT+svkyQxiCL117uPymj6HrowBasQ9jHTk2J2viKOiaTBr1mD0asD1+tVNwoCGXvdl+l+BZ1Mhs9EkuVoMPc1U4y/uRkyidO4IhXbcW1f4aQFGFYMwWveqpcR0KOQSqdFtf9kAIOALOyS1QqdTixnfwFBKuapLU4BEvguPs/8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7ZXO0X3++86ELs/gaJ4Kzq5+T2fD1qfY8HK5nO9StI=;
 b=wyoPz4JPI6+UWQpH0ITMpOgy5Y5otIt19/eyaugJrizTKOYkCsMoW8cAvqRnUEp030/JtbXfyXqAybw1qA9+QkOoc/cfBRqokYaAHRsJ7ikqj+BPym1EzpbkmFsoB0XGwTuJe+nEaplBFiY6/AnGzLaqRbEah0CJcB9XUwxqx4JMUY9q4d6HI6HXWCCMqUH4TT1+uUGHAXAgcW6WqaZ4M6VWbbP0wh5dhU2MF0oeVNvLWpZFg/KboZySSfkJInsgW7m3RiWjczwRLLhPpVJ+JVoUbqNJHsofXyArWbWQsWODQd51dedCUCNZSvFq9er72n6qAdGw2WXifYsBq27K0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BN9PR03MB6090.namprd03.prod.outlook.com (2603:10b6:408:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:34:49 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:34:49 +0000
Message-ID: <2b218680-ea43-43af-96a8-33f2609510f5@altera.com>
Date: Mon, 17 Mar 2025 15:34:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: m10bmc-sec: change contact for secure update driver
To: Peter Colberg <peter.colberg@altera.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Cc: Peter Colberg <peter@colberg.org>
References: <20250317210136.72816-1-peter.colberg@altera.com>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250317210136.72816-1-peter.colberg@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BN9PR03MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 4781fffb-bb7c-433a-fd00-08dd65a3ec99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEZnVDE4R09icGllWEJRcXV5S3llNlA4cnBiS04zQkxBOURMcjdIQ3hGaHpv?=
 =?utf-8?B?RG5VSkhFMGZDMXltQjlnRmR4UHBzQzZLN0wyOGdmbTB2d1A0c1NsMUQwVmtY?=
 =?utf-8?B?dEY2UmkzcWw1SHFjT0NHYWU2VjBZMGVPTXBoS1k4YTJOZ1Arcmw3U2QyN1Zt?=
 =?utf-8?B?bEtnV1RvUmQ2QjZzZmd4am9RWWVvRFpDQWx5MURyVm03YnJQQmQ5YWZkKzdz?=
 =?utf-8?B?dysyR1VPdFVRKzNtWGhuVGlMbUhjTVJueHgzdUExNzh0dnJmazU2cGdEcWlO?=
 =?utf-8?B?Z1VMRDFPV2ZxNFp1K1N6eFlsTFFNVVZoZFRka1VYT0Zralp3K0ZpRE1oOEc3?=
 =?utf-8?B?cm1lOWFCVlJhbkhwZWEvNEM3bHlqZERXMlUrcHJjc1JBS3B1S2lkVXlUcGds?=
 =?utf-8?B?SkQxZS9jSW02S0JiTmp2YTdqNUhuOEZVM09pZ09oUFV0SjNDUUlkR0N4cHdx?=
 =?utf-8?B?TWI5WFN2OVVtclBQYmVGRlBBVFRhbkpKVXo3eWV6OUdJNjFyUmQ0ZHlwd3lD?=
 =?utf-8?B?NFRYODkzRVVnK2V5SVh3bEtjQUV3Ym9XSUxoREc3c1dsRFRLNzZ3T3RrWGts?=
 =?utf-8?B?b2xsVDhIcE5kWTNKNW9JUTV5TTZJc1ZTdGJuTG8zanZGZVdhbkZnNDNSMXA3?=
 =?utf-8?B?U0x6NndUMk81WHVXOHl1TTJjK3hkY05qQmttYjNNRFhENC9WeWJuS1ZIUmt2?=
 =?utf-8?B?WFJsM3ZFOWRlajZTejhpYWlmejlIRC91akZXZk5YVHl3TkxLVWJHMnFzS1Ix?=
 =?utf-8?B?Y2hoOXBvMllXY1lacTlVZmVKSUNhbndJdURkclZKbFJXYWh0SGdVejFkR092?=
 =?utf-8?B?b3RaTWllbTlQZGdGcUJKNGdReExYa1dNaXhCcy93alVFeEtwS09FRDlLV2Vq?=
 =?utf-8?B?ZEFUWU9tTExTUFZGd1VFaE1SN1gxeHI4UDUvOHhzS3ViblcxVjZmaitNci9i?=
 =?utf-8?B?ejVhdzB1MDFoSWhYSUFyYUNwYmpRUGV6TjdmRUQ0Y01IeGxYdGlPYzllRTNr?=
 =?utf-8?B?KzJMVFRMSFRlcmRRZ2tZbERLeXNuYXBXVy8xek9xaGo1ckpKdUhWMzJieTF5?=
 =?utf-8?B?cXhzbjNWZERmWG1XeGhtbmlaS2luVklMTm5VMmd6T2VSMHVGNm0zY3ZaL1hL?=
 =?utf-8?B?WVk3b2Jubms5aXNabmlPVnkyZTNhQnRQSEQ3OXp3SnpMaE9LdTdQbnZoejMv?=
 =?utf-8?B?Q01BdXdaUVJIUlZydFEwMm80RUNlWE00ak4vNHBiT2Q2ZWNZRkN6YjhvSmpD?=
 =?utf-8?B?RU9mWFc3bUpqdWxFNUZmZldUNE9LVXgvVmpaNzBoU2Y4YmM5SVhOdXJ4YTBL?=
 =?utf-8?B?NmpUN3R5RjBCTjdOekhwYU9JalR0Y20rSFJQa3F2SWlkL0k2dCtWcXI4SXFZ?=
 =?utf-8?B?Q1c2OWZOdkJPdHhjWlUxMW1XTkVvZDV5d0xmZDBnbUpPbnIwL2hFaVNxemlp?=
 =?utf-8?B?WkhjSmM0cm5MSkJDNmJZU3dvZEZQRmFvNXpnV3BJeUdwaXNlaUlMUHpVVGdi?=
 =?utf-8?B?b1RKelQrVHI0U0JKSUM2WjQrTUVhdnQ1YWp2aXFFdkkxeVRubU0vcEhiVXVq?=
 =?utf-8?B?RlZMT0JjNVRMYXlKbzluTXVqV1M5RGt2MDdzak5uS2pOVCtqQkZFZGtQaDZj?=
 =?utf-8?B?TjlRbnBzVFIxRzV2MnBmSHUzOWVNbDlZWDIzek5od0MrZkNZK1NMWVNYVjRI?=
 =?utf-8?B?Rk5JOUNOeTNXMEZQZVFLZXVBOC9FUTVvUlZ5bkdVZGUxM0pEN05pTlJZdXY2?=
 =?utf-8?B?M0Vta3p6YitYSXE5QmN6TlJzVTJBSDRHOXRmZG1XVStkdHF6MzEyQ2dDTmpF?=
 =?utf-8?B?ZGIxaDRFbVkxNTFiOGFSb2NvaVhNTEJVV2VSK1gxSkFVUElpeGwxci82WkpT?=
 =?utf-8?Q?qWJkWzcGrAwX9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG93d0Y0V1l4SGUwdEFFU2dsOGd3K1NKRnNzd0t0cXRQRjFtM0RZbWNGcVNP?=
 =?utf-8?B?bzBubU0xTWNtdHVoM1h1Tm1NeUxZOE5vYWtHak54d2NBQ1dkek5INlZ6aUpG?=
 =?utf-8?B?M3lpL0M3MWg4cHlRcWVIcHBwdi9jVDN3QWJ0WktERkcxZmQ4TXpBT2N6eGN6?=
 =?utf-8?B?VG02eXJmMUZqV1FGTlFlZWw1QnNMR09lZ2RjeHE5Nkt4STI2VXQySHloV09q?=
 =?utf-8?B?d1NOdWcwWGVkWnV3YnVwTlZweVNzRE1KbzdsUGJYVUpYUUxuNGVMdjk3RHdz?=
 =?utf-8?B?MG0yNDBRbmdVa2wrSnQzTEpyZzBJMzNPS29wQUFhY3FpR3NYZFlad0F1c1Jl?=
 =?utf-8?B?ZUR3WkpnSmZuWUQrWXZPRUdrdEpTOFNRZG01d0lHcDlkQWhkdVZFUmppdVNL?=
 =?utf-8?B?OWhIRWRZR1RYWVczQlE4N2lHdGJnZHM4Qk1sLzhraWdaOFI1N1VkOWZ3Snpi?=
 =?utf-8?B?a2N6SGhWaTBZQlJUNko5OHhxMERMbmZ5Q0l5MDkwTFBkdHRzekcralA0MDVw?=
 =?utf-8?B?aDgwMTAvOW1oMk9CQm9KNEtJcmw5NEl0dmc1SFpjYkRHbW4rejFlcDgxeU52?=
 =?utf-8?B?K2dYOWE2RmdxU2hqWmlQMkw0RzMvWFFYU1p5ZzJRY05Sc3hLVHR1RXZrYmJx?=
 =?utf-8?B?V1RIbC8wbERNV1NPV2ZCMHVFNDBITjdWTUVNZjZsRjUyek1uckVsSnA0cWsz?=
 =?utf-8?B?UzFmb0NCSTRGdUF3cmRTZk52a3dKRm1neVd2VzVxZVQ1dkZEdzhzNk1CcG9W?=
 =?utf-8?B?bUxJenlkSHlRM2xvQkFBSGMxemZYS05mdWprRnNSYXV3dlFoeUlrTDJsQ1pq?=
 =?utf-8?B?ZDdkbDJiM21ablpiU1ZvWEF1dk9UckN6MktyTWdudUZHMHczaHIxM0sxVVNN?=
 =?utf-8?B?NWY3a3N4V3c4c3pjVGFoUHZnNnlTRFJmZk1ZZFZIVElBamttN1BWc3VKVmFs?=
 =?utf-8?B?RUdEZ2diSStsU3ozTGNhdnRERlgxNGhsYU1HZ2RyS0NNeVRaNVpCUU14cjV5?=
 =?utf-8?B?YU1RdmJORHBqUXNrQXZRYUJJZXZoRjZxanZlSUdCd0xyWDVCRFN3MjlLZ2sr?=
 =?utf-8?B?NGg1b2twNkxnaHEvZGdCaGZOTWo2QWdsclFubGJucm5SRFFzNmJHSW9TdUNB?=
 =?utf-8?B?bGUydTRYdlBSZFJ4dWRjbFhlUitwTGVXaUVWV1R0b0VEb0VGQmJ6NERubVlw?=
 =?utf-8?B?bTFIWHFtSVhrejIwY2JYL1gxdG44VkkxMGZMRkIzQ0RNVVhFaFB0T1gzbHVx?=
 =?utf-8?B?a3RQOUdQdU1FcVgrRTRkQThMTFJnWnhTM3YzRlVHUmRxUG8ySDl2MkZUQWdn?=
 =?utf-8?B?NE5iaGtZS0h2OUhZRVh0a3MreXNFTnpLd2NiMmxMNW5vZGlnYjdSdEE1WGtX?=
 =?utf-8?B?U1I1ZVVKUmNqNXVLNFpUelQ3M1V3RVBuZVhWUEV6b1FBSUVDUFNJZGhVSWk1?=
 =?utf-8?B?M0QwT3N5QkVsdlQwZyt2RXZOeGRTQSsxR2tyQUdJTTFsYjBneHN5dFFDdS8x?=
 =?utf-8?B?ajJqc0o3UkhuZnZBRTY1SElHcllzaUdkSk1QaEdMODJjdU84RFh2MDVDM3JN?=
 =?utf-8?B?Q0hpRHU0VFFxSmd5cThVaWVGWXpKY3hhQm01Q09GK0RtUEYyYXBrT1VZbmRU?=
 =?utf-8?B?dkk0OHJvODJrNU1Uc0tCK0Z3b1BBMUlFOXpyVi9TWjUreitDR2ppNjBLYWNh?=
 =?utf-8?B?MFFFNTc3bmtBM2N5aE82TUx2cll5N1EwVE5jR1lJc004SHBaTFJpSVJBT2Vh?=
 =?utf-8?B?WGJhVHVkcDM5NFhlbU5DU3ZxWkNHVzVaMUpEcFJSMDg0VmUvVXFOR0w4cmNM?=
 =?utf-8?B?bUtBaElxSUtQL0VwYzQwRldqY1RoNytwVVBIWit1R05SMVc2ci9USXNzOUlr?=
 =?utf-8?B?aDJ6OExieFdOWExKWFI3dEFhYWhxcGdIUVVJdEIyY2QybERqUnBwZyt0NXJZ?=
 =?utf-8?B?alZEeXlDWHF6Tk5rREFKTkxmQXg5QnNoQndtcGx2WkEwNG9XV3FFZzZSem9Y?=
 =?utf-8?B?ejQ0SHhzZ1U5WkVUWlhIdCtDMVBlWkpmRU5mWnZiaklCbVRqbDlXZEcvb04x?=
 =?utf-8?B?eW9aSXF2bTNzTDNReTczNVU1Mk5ySy9pcEhFZVBpZTlSWVdDTU5NWTJCYXpn?=
 =?utf-8?B?VkN6SXJ4cjVmUU5XeFY4aE12RlhlVHllM0w3VTZzMVdGeVJLYlNnZFNLdGxw?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4781fffb-bb7c-433a-fd00-08dd65a3ec99
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:34:49.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyElMFO/fx+VwNMQA/Vst/9WWqNy9g4u1WLtteIvsM5EI39oQHi6tyOAcGuqzQhX92RAo1zr94RhTixN+9siZAI75PE92qFRdk9dvdXmqok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6090


On 3/17/2025 2:01 PM, Peter Colberg wrote:
> Change the maintainer for the Intel MAX10 BMC Secure Update driver from
> Peter Colberg to Matthew Gerlach and update the ABI documentation.
>
> Signed-off-by: Peter Colberg <peter.colberg@altera.com>
Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>   .../ABI/testing/sysfs-driver-intel-m10-bmc         |  4 ++--
>   .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
>   MAINTAINERS                                        |  2 +-
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> index a6e400364932..faeae8fedb14 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> @@ -17,7 +17,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
>   What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
>   Date:		January 2021
>   KernelVersion:  5.12
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns the first MAC address in a block
>   		of sequential MAC addresses assigned to the board
>   		that is managed by the Intel MAX10 BMC. It is stored in
> @@ -28,7 +28,7 @@ Description:	Read only. Returns the first MAC address in a block
>   What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
>   Date:		January 2021
>   KernelVersion:  5.12
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns the number of sequential MAC
>   		addresses assigned to the board managed by the Intel
>   		MAX10 BMC. This value is stored in FLASH and is mirrored
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> index c69fd3894eb4..3a6ca780c75c 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> @@ -1,7 +1,7 @@
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns the root entry hash for the static
>   		region if one is programmed, else it returns the
>   		string: "hash not programmed".  This file is only
> @@ -11,7 +11,7 @@ Description:	Read only. Returns the root entry hash for the static
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns the root entry hash for the partial
>   		reconfiguration region if one is programmed, else it
>   		returns the string: "hash not programmed".  This file
> @@ -21,7 +21,7 @@ Description:	Read only. Returns the root entry hash for the partial
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns the root entry hash for the BMC image
>   		if one is programmed, else it returns the string:
>   		"hash not programmed".  This file is only visible if the
> @@ -31,7 +31,7 @@ Description:	Read only. Returns the root entry hash for the BMC image
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns a list of indices for canceled code
>   		signing keys for the static region. The standard bitmap
>   		list format is used (e.g. "1,2-6,9").
> @@ -39,7 +39,7 @@ Description:	Read only. Returns a list of indices for canceled code
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns a list of indices for canceled code
>   		signing keys for the partial reconfiguration region. The
>   		standard bitmap list format is used (e.g. "1,2-6,9").
> @@ -47,7 +47,7 @@ Description:	Read only. Returns a list of indices for canceled code
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns a list of indices for canceled code
>   		signing keys for the BMC.  The standard bitmap list format
>   		is used (e.g. "1,2-6,9").
> @@ -55,7 +55,7 @@ Description:	Read only. Returns a list of indices for canceled code
>   What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
>   Date:		Sep 2022
>   KernelVersion:	5.20
> -Contact:	Peter Colberg <peter.colberg@altera.com>
> +Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
>   Description:	Read only. Returns number of times the secure update
>   		staging area has been flashed.
>   		Format: "%u".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f60ff1957b0..9d22c4015e67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11833,7 +11833,7 @@ F:	drivers/mfd/intel-m10-bmc*
>   F:	include/linux/mfd/intel-m10-bmc.h
>   
>   INTEL MAX10 BMC SECURE UPDATES
> -M:	Peter Colberg <peter.colberg@altera.com>
> +M:	Matthew Gerlach <matthew.gerlach@altera.com>
>   L:	linux-fpga@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update

