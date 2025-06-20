Return-Path: <linux-fpga+bounces-1252-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EEAE19CB
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Jun 2025 13:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F2C7A929F
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Jun 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C328935C;
	Fri, 20 Jun 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cfmWqbhE"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AE257AF2;
	Fri, 20 Jun 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418117; cv=fail; b=Pos75dce6ke9GXQ/np3gnEizmTdHmOmmwDvR2TRAP2EpRBG5LahthEilGzccK0fuZvja3VEU8B1KN47HmBxpnMUeVcbvE1cqc9N+nDjo36dNc/49De1Ua2FfNaEv4ufU1AOVNmgj/dW72wFHMQDIH44Gt8+PQnOlOVXb5eyxu5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418117; c=relaxed/simple;
	bh=m7Gz4oJneVTTX9zUlDes6xLwFOBUcIYufAvJMStT6O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pO72nnAYpFWmOmxq+pUFColAPW74/nrrTNsRViIuWjZdM/jMfwVS0q2rjBc584ejIiNKEidMk7vHH5Qp4einl1+HPNuLRFDNJf9ZoIzeGNWfvPgh8w0EmU5aK00PkQxtiImM7/LqhPAjTk2bL01/PN01geeZQStdeNKfkGkkmjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cfmWqbhE; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJT6igkxscUAqufKMPUYKTBueucXEjyNPa0wUuuGYIpVuLstMXwgY2vRFA+76Cc4UzNK8kKNAvZTO5OhRQH1lkQLbFrxGmSeFOHxyR2mQTzvQA6ITbz0VwPinmjQZyiMoMv3ff3HEmPfZjzr5rVJY7d42ruwgbQhkwMW8ZMj35+sRdgQskZ16Jdm3+RdsLBqHay1Q626JEnGutcQgR9wy2Z+bpJyyEojd9hpnFrTE4ZqFNVeiMbbYI8dXgQGCtzC8Lg/nMukxI9bAN12T6JzoRfHgIWIcvxsAtRSCJPnYNnOlfe3bWu7atDecogMc54O7s0jcxHnYlDjV+RsqRU2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QC/Pcry1LyLPg6N7vinib4eMvVQvOZslRrWH0dIMB0=;
 b=riEWYxZTpMnEOEGfjVISWf/drj8sKWh/SpPT/Xmjay58yt23TGNbF4s1mG3eu1Ki/bSv0fbYKj1eF3PIuRmn0nzHfD5RP9BVwdT2gE06kcRgtsocV+fkBYbwiHoNFofXCYJkjemORbcNwc/Azo4raYLa196MDHtbgg7j+E8lBmC6jhdO8f3olkdTk7dodExKtA8eOVbUM/LbIcW4JzlNIpDPD/xH4w/ELoxI/iD6Nqw88yZytQRadSW0D86iucsXTXFcUbugy6PseNxFMGVyAJpZDRmRn6oX3c6cvuYkQFO8YdBVemU2K8t8Jg2w/iUX3XrgjbIdr254NeEDWSxjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QC/Pcry1LyLPg6N7vinib4eMvVQvOZslRrWH0dIMB0=;
 b=cfmWqbhE9kbMjOwjsIEZa1Dm2TXtdSc9DOdlXs3aFoegBonWmE0xuL56sxh/mFCj0pRH1jJ3vR3NTL8+YEr28cEwu3/SysPsphl0+TC526in54h9Sk7+wO60mz5bi4qoWGi2+5Ib1KDFSD8sj91dm6oqLeg9uTRSzam9kTP9YsQ=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 SJ5PPF2CD49510F.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 11:15:12 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%4]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 11:15:11 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>, "trix@redhat.com"
	<trix@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Topic: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Index: AQHbyHAvjfKTIyDsoE6M6pJ/SBy77bPue0MAgBDjfuCAAab5AIALDxoQ
Date: Fri, 20 Jun 2025 11:15:11 +0000
Message-ID:
 <DS7PR12MB6070BC635C899C637EDE71F3CD7CA@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
 <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
 <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>
 <aEv48IZSinWjJgBt@yilunxu-OptiPlex-7050>
In-Reply-To: <aEv48IZSinWjJgBt@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-20T11:02:46.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|SJ5PPF2CD49510F:EE_
x-ms-office365-filtering-correlation-id: 6ae930ad-81e8-45c6-c9b4-08ddafebb953
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OWRPcHNXNFQyeE9iTW5tVnduSXlmMyt3WWRSZUdvTWpSSTlFcDRPZlFP?=
 =?iso-2022-jp?B?dXdSSXhvR09tRmt0VjVhRXphWjR0Z1E5UmVaTlpLVTVMK1JaeU9UYkgx?=
 =?iso-2022-jp?B?QkhXRkZSSlFtdjNCL2gzRENpZWtyVEt3Q0pqM25tQS9VaXFXam1keGxO?=
 =?iso-2022-jp?B?enVOa0RORlVyOTZXbXVwaFdybDZSSWlFaERyWUNuWnB1SFJRZGRVSkRy?=
 =?iso-2022-jp?B?TVM5L3ppSlhGSEJjc2t5bGVOMnIrczJEYitCMEJMYUc5em4zditQbEVU?=
 =?iso-2022-jp?B?M1NsaVlPTTF5RlhMblNVNmpDL2wvV01lTCtSOEppZjhHeWorVWlRRDdH?=
 =?iso-2022-jp?B?c0cxeFA3RFVqT2F6ZG0wcG41VThVMldzVkpYbFJKRWxFQU9mTlV3dWEw?=
 =?iso-2022-jp?B?Tm5seDZSbWxZcXJDRGtCZEFDd1kvY3lLM0pkaDk2K09mN09IK3F3TURq?=
 =?iso-2022-jp?B?cE1NRHV2ZUpwc3RUUkdycnkvQzFzRVZyeEZ1WThJMDJka3czRFBhT3Vv?=
 =?iso-2022-jp?B?OVVBYUp1Uk1KSlAzUThGWk9Fd2hRZXR6bC9zYXFNbUVQcXhnbnFVQ0Ji?=
 =?iso-2022-jp?B?SVlvYWxsTjdWYm9DTEJ6aXNDQ3N6YWQvKzBwZWkyTFg1YXFWeDVNc2Rk?=
 =?iso-2022-jp?B?blRVcER4NDJGTndONTlHaXdEcjdqL1dXQlY5WUNvcjUvdEVxZUNkbzU0?=
 =?iso-2022-jp?B?dUJGU3l3L3JGZEM3NGJBSmVvc2xOQkVXUnp0WEtJMTlVRU1QZkN4Tm1n?=
 =?iso-2022-jp?B?eXBPQzZxbWpEWmhwYzdoT0JKUGlGZFBRdzJkbDdvR0g4eE5HdnNKcUV4?=
 =?iso-2022-jp?B?SzVTeGVlRDhzT3QvVlJYTHlwY0hObUFXV1EzV2g0cGNOVEtsUUFMNGtM?=
 =?iso-2022-jp?B?Z3ZNR0FTVEdaSWdvbTdmQnNwNC9tV3Izc2tNeHZyOG4yR0xwbXZBckQx?=
 =?iso-2022-jp?B?b2JXenVDUk9IRTl3S3pzeEtuaEFsUm0wQmI0TFVkMGJ0ZzZuN3NOM3pa?=
 =?iso-2022-jp?B?OVhnTTRQbllFdVE5SG9kSTN4Vmx6VlFFSWhuVzJvK0FrcHpLUnpnM3NM?=
 =?iso-2022-jp?B?UGR5LzZHcnE3WTdXOEZyYS9lSmVEbGxKSktjdGZEYnRCZ0tWY2hvcmVZ?=
 =?iso-2022-jp?B?dnJmYUdHdk0vTkJyYTVmNVlLdzNjLzcwMVJkeUszeTFDbGJFR1BrQVJB?=
 =?iso-2022-jp?B?a01GeXdHVEVnUW1VSDUxdWpkWmV2YzJReTJscDV1Q1ZKRklIK2xaazlU?=
 =?iso-2022-jp?B?NWxpV0dGWTZacDdDaWprQmJyVVhPand2MDhLam5ZNU8xTk1vMHNKNzkz?=
 =?iso-2022-jp?B?UDZiUUw0TVhLT2Z3ZGZqZ21mQ3J0Mm5mMlMxZUg1VHpiNVZLNS95SzVN?=
 =?iso-2022-jp?B?ek5tWUpTdnljTmNFbzlrem5JUDRSTWhlQ1c0VnVrMG5OZG1peU9aRG9I?=
 =?iso-2022-jp?B?c29XdTM0SThCZ3U1MkdjMk54b25mZDBVamtpV0IxNldGZ0pZTlRXYWlt?=
 =?iso-2022-jp?B?OGdOZ1dzc25qWFVXbTZxeVJqUVBScC9lTHNscXRHM0c0amc5YlJiWitl?=
 =?iso-2022-jp?B?N1Y2U1F3R0Y5RzNEdnM5Q0tPaEZaRDhFbGFjRXg4RW0vRjgyc1pCUEJy?=
 =?iso-2022-jp?B?bFhEdTJWWnRnMkkwUkxxZWMyZm5rWGh4TFIyQ1lYbHZESlZEODlqaGpW?=
 =?iso-2022-jp?B?TzFHdS9yQnBDdnRJNGNleElmdVM3N29DdllVNm80VTNVUW1ZbzVzaUp5?=
 =?iso-2022-jp?B?NGRreDVxbEdyZk5kVXc5SzFQWXlXUEIrWVFnZXhFT3NWbnVCQ1NPeDJn?=
 =?iso-2022-jp?B?NDRLWGg3dU40aGVjbXcrOStwYVRVMWZiSWtzUUszSzdKM1RsK1FhNVJJ?=
 =?iso-2022-jp?B?eVI1VW5CcStVSUk5aklLeEhkOHhKZjY2Q2V1dlBvQ3ZmajE2V0RMcURQ?=
 =?iso-2022-jp?B?SWViRy9QVEVLdTJTTHU2cS82TTFsK2M4U0VpalFZaTdqbFNheGRMS05T?=
 =?iso-2022-jp?B?L0tWU3dtdEIwVHkyZFgyOEZYQ3JBUU96cHYwZE84MjNSMjJwb3Vlenha?=
 =?iso-2022-jp?B?bmxWUU9GRUxHdzBZTFVzM09hUmcrbUdPUlJzQUt4ME1SLzBCYkNFRVhl?=
 =?iso-2022-jp?B?LytpenlvUXk2YXJlakZkY09NYW8wVEpjUHNTRUIwRmZHcWtXTFVKRkJp?=
 =?iso-2022-jp?B?VzRrPQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bDlnMU1hOS9XWHVHcGZ6YmhiOFVxZW9tTzRoUVJWaitpWEhyUDFaLzYy?=
 =?iso-2022-jp?B?bzZTVDNYU3VHV2ZVNUpoK1g0ZzkxR3FuMnU1K1ZFNFhGZWtTZUlwODQ3?=
 =?iso-2022-jp?B?R0xMRDZ6RG91OXdrbmJsRzJWdlk3VTRyZzllQUdLQ3kzSzNQNS9YMDhr?=
 =?iso-2022-jp?B?Nmt4Yk1QMWVQem01R2o0RWRCYS9zUG56YkpzY2xqMjNER1hwU1FFeUt6?=
 =?iso-2022-jp?B?SzNzSjlNS2lsSHkwYy9DVXBrdlE4VlR3N1hIZzlYa09VOExXbnBFem9R?=
 =?iso-2022-jp?B?S0NpYW1KdGhxQ3BMODBIbTVWNS9sUnUvOFFWZmlrQnJEeExGOFNWNlpx?=
 =?iso-2022-jp?B?NTVKcEtMWDdMM2x0ck4wL2ZyQ281OTVYOTAweW54eFVkY1k0M0ZCbFJj?=
 =?iso-2022-jp?B?Vzg2OVJ2SkxQNnMvUlVJUzNuUlY3RGJWcXZqbXFUN1RTTVR1U2ZTdHRm?=
 =?iso-2022-jp?B?Q0hHZXhOZGl1UGlpNm14aTByOHVyYTcvS3E1U2RGS1gyLzE3bkRZb3Jx?=
 =?iso-2022-jp?B?NWpFb3liNGs3QjQ0bzZZMnBtL3JiTXRvVmMvNVZwNzN5Z3lJNXp2Lzhm?=
 =?iso-2022-jp?B?REpDUElBSXVLdHhCYUhQVDJDcHRsQUI3RHZKTURSUVBabzBkaGZIWHN1?=
 =?iso-2022-jp?B?N3M1ODB5WERnb1BkU2JsR3ljM0ZXU2t2b1Q5aEdhZUU0anFEMlVlKzJN?=
 =?iso-2022-jp?B?TitTL1lFekhQYmRwUGNzWGJJNmJicmRRNllTN2VUTTl1ZHZYZHdnY2Fq?=
 =?iso-2022-jp?B?QklNUFBWb2lyTnBVTmpLSFZpRnZ0aWwxVmxzVkJDT1NLQ0lkR2VXWVZw?=
 =?iso-2022-jp?B?RlR6akJDMWtCMWgyWVRqQ04rc0paYlFMbUg0SXhoN2dmem9LL3A5V2xQ?=
 =?iso-2022-jp?B?eS9BTkRqUGlBNEpTU1c3TlYzOWNTM2NiS2VlQXZQNDQ2NDJmMGltZTRk?=
 =?iso-2022-jp?B?QVorMzVkT25jTXBka3ZzMEFGYlhNZ0tjd1l0bE1JY29NRUxIOXM3dTh3?=
 =?iso-2022-jp?B?WHlHMkdzZkFYcGxkeWJHT2lDVnZtZXkrSHZKclJHK1puMWtpb3JxS2Fp?=
 =?iso-2022-jp?B?alc3VDBJZncyREVzZHliTkw2RmpBRVo1dXpXaVhKQkFCdWY4ZndLczVr?=
 =?iso-2022-jp?B?VEpnREEzQnZqVmRobXc4MlMreEFPSzlKT0dsb2ZNdS9lNXlPQmVjTHhY?=
 =?iso-2022-jp?B?a0NyNUpCME0weFl4SjV0bThMeWdwWnJBam0wR3lmUURiSFdnU043R0l0?=
 =?iso-2022-jp?B?QUhWeVNTSTYxWjRSaUU1d3B1VHIxUlJaM29kMUNraWVpQWUxcS9MWnF6?=
 =?iso-2022-jp?B?UHpZTFRxR2JhRllYc0pyZGNIVWhDd0JVY3pNdzdvOVBlWkVUMkFOQ0p1?=
 =?iso-2022-jp?B?b2V3UEtJS3Y4NFlKaVNPYVg0TEw2TWIvbkNZSTBkT0piOUtubXpuY1Qw?=
 =?iso-2022-jp?B?MERWT1hjTCt5TUVvWGZPN0kwZGQ0Zno2M01HbjNGelMvRjZyY3VvU3pw?=
 =?iso-2022-jp?B?MHRwWTRENGJEb1NuSVg0SzU2UThzZy9xb0NsYmFkWHZFR3pBMWRJb05V?=
 =?iso-2022-jp?B?VEU5cXhpQzg0WUVrMkZ6Tkx4NGVKd0hWQWh3RFI4QnZYdjZoaE0yS1Q1?=
 =?iso-2022-jp?B?S2ZqZmZmWTNpQmVmYXRLZ0FUTFQwbDluN1JGemgrK3YwUURQQ0JMMndt?=
 =?iso-2022-jp?B?VUNMZktOeStHMWdnMGR4Z0hlUEpHcm9TOTA4WkxvemtGSDdva1BQZDdC?=
 =?iso-2022-jp?B?UFN4N0xFSTBGUUxLdXQ3enREejNCSWR3eS9CbWFHZ1h0a3ZqK1FjUERS?=
 =?iso-2022-jp?B?Q09mQmtwVTRtcU9Fd2ZXcXZEUDNXdXoybDdoZitUMmJJbkRYbTZwdWxw?=
 =?iso-2022-jp?B?Vm5uNnRNbUtKOVI0amcvRjRZOE8wQ1VHZnk5RjVMaFNTRG0wNFlITTd1?=
 =?iso-2022-jp?B?VFNtT3BoREltZDhqVjJzWkJjRWZ2V08zanEyQkVwVVVVa096OWIzM3Z3?=
 =?iso-2022-jp?B?MlF1anc2bUFNajUxU3FsK294RDFoRk5LVWVsUUk5S2VOdThuWlBqa21t?=
 =?iso-2022-jp?B?MTQ4SzB4SlpydUVzVEM1SG9rVjQ3WUQ3ZVAyUTZSd203MWlXam1zSVhH?=
 =?iso-2022-jp?B?eWVITDhkOUFTNXVOUStwQlVicE83MnhOM2NOR0VraVhSWFpTSHRFN29I?=
 =?iso-2022-jp?B?dGdWTDhEM3NkeEp5NVNtNmdjS0tLaGxLalZjL2gwYnd4NWJtcHl1cnBi?=
 =?iso-2022-jp?B?RkRuY05FT1kzMlFWbjFTb3pFVzYycCtCVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae930ad-81e8-45c6-c9b4-08ddafebb953
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 11:15:11.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10ICcaG8Y5yfqWaPVWOmwoJsSR6BZRwaQcPZWYlPprpmVRHl8kg5KxVgisj2rmOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Friday, June 13, 2025 3:40 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com=
;
> robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for r=
untime
> FPGA configuration
>
> On Thu, Jun 12, 2025 at 09:05:21AM +0000, Manne, Nava kishore wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Yilun,
> >
> >         Thanks for quick response.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Sunday, June 1, 2025 8:32 PM
> > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > > trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > > linux-fpga@vger.kernel.org; linux- kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface
> > > for runtime FPGA configuration
> > >
> > > On Mon, May 19, 2025 at 09:09:37AM +0530, Nava kishore Manne wrote:
> > > > Introduces an ConfigFS interface within the fpga-region subsystem,
> > > > providing a generic and standardized mechanism for configuring
> > > > (or) reprogramming FPGAs during runtime. The newly added interface
> > > > supports both OF (Open Firmware) and non-OF devices, leveraging
> > > > vendor-specific callbacks (e.g., pre_config, post_config, removal,
> > > > and status) to accommodate a wide range of device specific configur=
ations.
> > > >
> > > > The ConfigFS interface ensures compatibility with both OF and
> > > > non-OF devices, allowing for seamless FPGA reprogramming across
> > > > diverse platforms.
> > > >
> > > > Vendor-specific callbacks are integrated into the interface,
> > > > enabling custom FPGA pre_config, post_config, removal, and status
> > > > reporting mechanisms, ensuring flexibility for vendor implementatio=
ns.
> > > >
> > > > This solution enhances FPGA runtime management, supporting various
> > > > device types and vendors, while ensuring compatibility with the
> > > > current FPGA configuration flow.
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > > ---
> > > > Changes for v3:
> > > >  - As discussed with Yilun, the implementation continues to use a
> > > > callback-based  approach to seamlessly support both OF (Open
> > > > Firmware) and non-OF devices via  vendor-specific hooks.
> > > > Additionally, the earlier IOCTL-based interface has been  replaced
> > > > with a more suitable ConfigFS-based mechanism to enable runtime FPG=
A
> configuration.
> > > >
> > > > Changes for v2:
> > > >  - As discussed with Yilun, the implementation has been modified
> > > > to utilize a  callback approach, enabling seamless handling of
> > > > both OF and non-OF
> > > devices.
> > > >
> > > >  - As suggested by Yilun in the POC code, we have moved away from
> > > > using  void *args  as a parameter for ICOTL inputs to obtain the
> > > > required user inputs. Instead, we are  utilizing the
> > > > fpga_region_config_info structure to gather user inputs.
> > > > Currently, this structure is implemented to support only OF
> > > > devices, but we intend to extend
> > > it by incorporating new members to accommodate non-OF devices in the =
future.
> > > >
> > > >  drivers/fpga/fpga-region.c       | 196 +++++++++++++
> > > >  drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++----------=
----
> > > >  include/linux/fpga/fpga-region.h |  34 +++
> > > >  3 files changed, 493 insertions(+), 211 deletions(-)
> > > >
> > > > diff --git a/drivers/fpga/fpga-region.c
> > > > b/drivers/fpga/fpga-region.c index 753cd142503e..d583fc22955b
> > > > 100644
> > > > --- a/drivers/fpga/fpga-region.c
> > > > +++ b/drivers/fpga/fpga-region.c
> > > > @@ -5,6 +5,7 @@
> > > >   *  Copyright (C) 2013-2016 Altera Corporation
> > > >   *  Copyright (C) 2017 Intel Corporation
> > > >   */
> > > > +#include <linux/configfs.h>
> > > >  #include <linux/fpga/fpga-bridge.h>  #include
> > > > <linux/fpga/fpga-mgr.h>  #include <linux/fpga/fpga-region.h> @@
> > > > -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[] =3D
> > > > { };  ATTRIBUTE_GROUPS(fpga_region);
> > > >
> > > > +static struct fpga_region *item_to_fpga_region(struct config_item
> > > > +*item) {
> > > > +   return container_of(to_configfs_subsystem(to_config_group(item)=
),
> > > > +                       struct fpga_region, subsys); }
> > > > +
> > > > +/**
> > > > + * fpga_region_image_store - Set firmware image name for FPGA
> > > > +region
> > > > + * This function sets the firmware image name for an FPGA region
> > > > +through
> > > configfs.
> > > > + * @item: Configfs item representing the FPGA region
> > > > + * @buf: Input buffer containing the firmware image name
> > > > + * @count: Size of the input buffer
> > > > + *
> > > > + * Return: Number of bytes written on success, or negative errno o=
n failure.
> > > > + */
> > > > +static ssize_t fpga_region_image_store(struct config_item *item,
> > > > +const char *buf, size_t count) {
> > > > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > > > +   struct device *dev =3D &region->dev;
> > > > +   struct fpga_image_info *info;
> > > > +   char firmware_name[NAME_MAX];
> > > > +   char *s;
> > > > +
> > > > +   if (region->info) {
> > > > +           dev_err(dev, "Region already has already configured.\n"=
);
> > > > +           return -EINVAL;
> > > > +   }
> > > > +
> > > > +   info =3D fpga_image_info_alloc(dev);
> > > > +   if (!info)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   /* copy to path buffer (and make sure it's always zero terminat=
ed */
> > > > +   count =3D snprintf(firmware_name, sizeof(firmware_name) - 1, "%=
s", buf);
> > > > +   firmware_name[sizeof(firmware_name) - 1] =3D '\0';
> > > > +
> > > > +   /* strip trailing newlines */
> > > > +   s =3D firmware_name + strlen(firmware_name);
> > > > +   while (s > firmware_name && *--s =3D=3D '\n')
> > > > +           *s =3D '\0';
> > > > +
> > > > +   region->firmware_name =3D devm_kstrdup(dev, firmware_name,
> > > GFP_KERNEL);
> > > > +   if (!region->firmware_name)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   region->info =3D info;
> > > > +
> > > > +   return count;
> > > > +}
> > > > +
> > > > +/**
> > > > + * fpga_region_config_store - Trigger FPGA configuration via
> > > > +configfs
> > > > + * @item: Configfs item representing the FPGA region
> > > > + * @buf: Input buffer containing the configuration command
> > > > +(expects "1" to program, "0" to remove)
> > > > + * @count: Size of the input buffer
> > > > + *
> > > > + * If the input is "1", this function performs:
> > > > + *   1. region_pre_config() (if defined)
> > >
> > > Please define explicit workflow, and explicit expectation for each
> > > callback, or this framework makes no sense. From your of-fpga-region
> > > implementation, seems
> > > pre_config() means "parse image", post_config() means "populate devic=
es".
> > >
> > > > + *   2. Bitstream programming via fpga_region_program_fpga() (unle=
ss
> external
> > > config flag is set)
> > > > + *   3. region_post_config() (if defined)
> > > > + *
> > > > + * If the input is "0", it triggers region_remove() (if defined).
> > > > + *
> > > > + * Return: Number of bytes processed on success, or negative errno=
 on
> failure.
> > >
> > > Please put the uAPI description in Documentation/ABI/testing. Then
> > > we could know the file path layout from userspace POV.
> > >
> > > > + */
> > > > +static ssize_t fpga_region_config_store(struct config_item *item,
> > > > +                                   const char *buf, size_t count)
> > > > +{
> > > > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > > > +   int config_value, ret =3D 0;
> > > > +
> > > > +   /* Parse input: must be "0" or "1" */
> > > > +   if (kstrtoint(buf, 10, &config_value) || (config_value !=3D 0 &=
&
> > > > + config_value !=3D
> > > 1))
> > > > +           return -EINVAL;
> > > > +
> > > > +   /* Ensure fpga_image_info is available */
> > > > +   if (!region->info)
> > > > +           return -EINVAL;
> > > > +
> > > > +   if (config_value =3D=3D 1) {
> > > > +           /* Pre-config */
> > > > +           if (region->region_ops->region_pre_config) {
> > > > +                   ret =3D region->region_ops->region_pre_config(r=
egion);
> > > > +                   if (ret)
> > > > +                           return ret;
> > > > +           }
> > > > +
> > > > +           /* Program bitstream if not external */
> > > > +           if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)) =
{
> > > > +                   ret =3D fpga_region_program_fpga(region);
> > > > +                   if (ret)
> > > > +                           return ret;
> > > > +           }
> > > > +
> > > > +           /* Post-config */
> > > > +           if (region->region_ops->region_post_config) {
> > > > +                   ret =3D region->region_ops->region_post_config(=
region);
> > > > +                   if (ret)
> > > > +                           return ret;
> > > > +           }
> > > > +
> > > > +   } else {
> > > > +           /* Remove configuration */
> > > > +           if (region->region_ops->region_remove) {
> > > > +                   ret =3D region->region_ops->region_remove(regio=
n);
> > > > +                   if (ret)
> > > > +                           return ret;
> > > > +           }
> > > > +   }
> > > > +
> > > > +   return count;
> > > > +}
> > > > +
> > > > +/* Define Attributes */
> > > > +CONFIGFS_ATTR_WO(fpga_region_, image);
> > > CONFIGFS_ATTR_WO(fpga_region_,
> > > > +config);
> > > > +
> > > > +/* Attribute List */
> > > > +static struct configfs_attribute *fpga_region_config_attrs[] =3D {
> > > > +   &fpga_region_attr_image,
> > > > +   &fpga_region_attr_config,
> > > > +   NULL,
> > > > +};
> > > > +
> > > > +/* ConfigFS Item Type */
> > > > +static const struct config_item_type fpga_region_item_type =3D {
> > > > +   .ct_attrs =3D fpga_region_config_attrs,
> > > > +   .ct_owner =3D THIS_MODULE,
> > > > +};
> > >
> > > I think this is still the sysfs methodology. My understanding from
> > > configfs.rst is, use userspace interfaces to control the lifecycle of=
 a kernel object.
> > >
> > > Now for existing kernel reprogramming flow, the image object for
> > > fpga_region is the struct fpga_image_info. We need to associate the
> > > struct with a config_item: alloc the struct fpga_image_info instance
> > > by mkdir, expose necessary fields (enable_timeout_us,
> > > disable_timeout_us, firmware_name, and the most important for
> > > of-fpga-region - overlay blob ...) for user to fill/query via configf=
s attributes. And
> finally use a writeable attribute (e.g. load) to trigger fpga_region_prog=
ram_fpga().
> > >
> >
> > Thanks for the inputs. We've now implemented a ConfigFS-based
> > reprogramming interface for fpga_region that aligns with the intended
> > lifecycle-driven model described in configfs.rst.
> >
> > New Interface Usage Instructions:
> > # 1. Mount configfs (if not already mounted) mkdir -p /configfs mount
> > -t configfs configfs /configfs
> >
> > # 2. Create a region directory (e.g., region0) mkdir
> > /configfs/fpga_regions/region0
>
> FPGA region is the device driver generated kernel object, so this per fpg=
a_region
> group should be created by kernel, not userspace.  User should create fpg=
a_image
> config_item under region group.
>
>   mkdir /configfs/fpga_region/region0/my_image
>
> >
> > # 3. Copy your bitstream or overlay files to firmware path cp pl.dtbo
> > /lib/firmware/
> >
> > # 4. Set the firmware name (e.g., overlay .dtbo) echo pl.dtbo >
> > /configfs/fpga_regions/region0/image
> >
> > # 5. Trigger Programming/reprogramming echo 1 >
> > /configfs/fpga_regions/region0/config
>
> My idea is, when an image item is first created, it is not activated, use=
r needs to
> read/write its attributes to initialize it, then we could have an attribu=
te (e.g. enable) to
> activate/reprograme the image.
>
> For example:
>
>   echo 1 > /configfs/fpga_regions/region0/my_image/enable
>
> >
> > # 6. Unload/Reset the Programmable Logic echo 0 >
> > /configfs/fpga_regions/region0/config
>
> Maybe we could just delete the image item for unloading
>
>   rmdir /configfs/fpga_region/region0/my_image
>
I=1B$B!G=1B(Bve implemented the FPGA Region ConfigFS interface with the fol=
lowing hierarchy:

/configfs
=1B$B(&(!(!=1B(B fpga_regions             =1B$B"+=1B(B Registered via confi=
gfs_register_subsystem()
      =1B$B(&(!(!=1B(B region0                =1B$B"+=1B(B Added using conf=
igfs_add_default_group()
           =1B$B(&(!(!=1B(B my_image      =1B$B"+=1B(B Created via mkdir fr=
om userspace
                =1B$B('(!(!=1B(B firmware    =1B$B"+=1B(B Write firmware na=
me here
                =1B$B(&(!(!=1B(B config        =1B$B"+=1B(B Trigger program=
ming/unloading
Observation:
If configfs is not mounted before configfs_add_default_group() is invoked
(e.g., when regions are registered early via base DTB), the path
/configfs/fpga_regions/region0 does not appear in userspace,
even though it=1B$B!G=1B(Bs properly initialized in the kernel.

This appears to be due to how default groups function.
they require the configfs filesystem to be mounted prior to the group
addition in order to be visible. As a result, the mount order becomes
a strict dependency, which may affect or break early-boot FPGA flows
where regions are created before configfs is available.

Proposal:
Use configfs_register_subsystem(&region->cfg_subsys) for each FPGA region
instead of relying on configfs_add_default_group().

This approach places each FPGA region directly under /configfs/region0,
avoiding the timing issues associated with default groups.
The interface becomes available as soon as configfs is mounted.
regardless of when the region was registered
(boot time via base DTB or dynamically via overlays).

New user hierarchy:
/configfs
=1B$B(&(!(!=1B(B region0              =1B$B"+=1B(B Region appears as its ow=
n root node
      =1B$B(&(!(!=1B(B my_image   =1B$B"+=1B(B Created via mkdir from users=
pace
           =1B$B('(!(!=1B(B firmware =1B$B"+=1B(B Write firmware name here
           =1B$B(&(!(!=1B(B config     =1B$B"+=1B(B Trigger programming/unl=
oading

Would like to know if this approach looks good, or if there are better
suggestions to handle this scenario?

Regards,
Navakishore.

