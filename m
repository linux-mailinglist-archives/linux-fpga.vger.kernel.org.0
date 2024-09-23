Return-Path: <linux-fpga+bounces-730-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479CF97E549
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Sep 2024 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B841D1F215B6
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Sep 2024 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E01FA4;
	Mon, 23 Sep 2024 04:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U4kLM+ws"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4610F9;
	Mon, 23 Sep 2024 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727065688; cv=fail; b=PCviWJ2j5wNk5RZPt6zWkWxNanKG9dvFU4tNUzKj/vbSlYKPisINVNs6ZcAxwd/T80jDk/bSn+eWZQxGcUReL33RioY4Ar9Guz8qSmSt5Kbxg562bUhGrgRwE83noyogkzO4VzNZsmHEbBC1zApU0LFuSda4yoctB40Tmq9D6wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727065688; c=relaxed/simple;
	bh=PR4hC6fbGV+QYsEe1WNZwF84L7Vr0VEva+r/1VAfo2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kl7IPwGlsoxbUpwhbNIStMio5vtI9d2t0COvT0pS3Eg+v3I+GOR7DJ/qjLel4Jtzwj4Nx4fiR9F4qdxEfduZTODfySXzAvCMX5/C58PXYZONo3o+JZ2+KObIA0LX8bsk3onNoSPFBVCCzaX3YwksylpdBLefTKVtX2n5fRNb53A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U4kLM+ws; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5nV9DivOPCuJ4zp+uqTdGAuNOXxKq+JlRazvK00TFIQoaxHVxogrryMb1U36kLwKuZDkEMC457pqOoZWWhfPx3gbd1jKQIHnc9/FFcOCRva/vfeaNsoZwl/e7ZtFhrrQI6HZZfwQGZdIytMcv3rbQV2dBe5EBoOJswzZ7KxX8QIFkt/FMARsYGlGFp/63p2QYXfJcsbl6hxhAQFCCzIbBhX5yzdXbEmvqvjLJjhOkJ1Uc7whUmU63m+9A5eJfyMtUMY3AONjYOJf/n7Xfi0Y29TUpYW/iTKeA3mQznZdwZzxZUHhDJKA7UWNm7dd7cMfCfIjn4uVc8yBZbaWxyT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmX9zQdfROEEw2G26Zzrbc3/+Ac56EZtGQm7drUIn48=;
 b=M2tFcCD/JgxXZIal8CRVIXHyLaK/5EE9GA6fnr9n6O14/FgP8SagDmZPoClfkU8eg4AZtPQwTUvHjbtbP1msTG1XMi6BW1jBWTCY8SWDm8UaPqdmwWiSF/lzR7OP644oh+V7lUelQ9DBPxu2IVX6Ud5p07aEa5uAsncTE0r0iB58nefWkE2W/X4TqNmyQkSfImOM4i8ZsCXMdW5xVWrakS4nUoEvXN9MY3EJJtABaGdlayja9WznY197sHsPklyMokWI5v1cQv45VzfSiom8Pj7mdYyhVoz2/9L+QtyBP0/p0YlCoXrkEj03FdahIcI4zmH3F3nMx+zk4Pg9E/kNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmX9zQdfROEEw2G26Zzrbc3/+Ac56EZtGQm7drUIn48=;
 b=U4kLM+wsxSqWZvF54OX5NyN6LMzrBWEjtOF/YWZiXkj27j+25BVqyPtW6B7Zr1U0A1nsoABmSoedK13FgnIRXvySW5GkKNauI+6C90aHfOPhinYeB1+VScX0sN1a4PqrnwLU/LZJ/rD+RKTX/aHnh1Pt/Ns5zE2k7GWrFhiP9M4=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Mon, 23 Sep 2024 04:28:01 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 04:28:01 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>, "yilun.xu@intel.com"
	<yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Thread-Topic: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Thread-Index:
 AQHa3yZuwBfgoAWoa0yxdButTACHTLIN4ZUAgAPvPVCABzk2AIBDFq6AgAFoF4CAB5cLAA==
Date: Mon, 23 Sep 2024 04:28:01 +0000
Message-ID:
 <DS7PR12MB6070C18273E3B9435A471045CD6F2@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
 <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>
 <ZrEX9HlAOlUtgnTj@yilunxu-OptiPlex-7050>
 <DS7PR12MB60702067EE3B40A4256F90D3CD612@DS7PR12MB6070.namprd12.prod.outlook.com>
 <ZuqNL41bgpPZ9QQ7@yilunxu-OptiPlex-7050>
In-Reply-To: <ZuqNL41bgpPZ9QQ7@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|IA0PR12MB7699:EE_
x-ms-office365-filtering-correlation-id: b472cf81-df00-47c6-2cd8-08dcdb881c17
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?204sS8SdNsBzquqoDHE/Y1io5xDNlRvWji0jE6IgFrBoKoQkonO9pzNz41g7?=
 =?us-ascii?Q?S2Q60V/8JHD7fOEvXxR/VJO3laIXGYXPLhl0RX0ZxBVZWiIQEU6dhf/UCSnQ?=
 =?us-ascii?Q?5l73STJaf1Ro70e3SbHd/1WmtjfWUEPH0EJzGCZqiTTZxbChF7g1o0mKc/bS?=
 =?us-ascii?Q?KOaW8zJZhUNMWDdt0KXle4HcfG8ncoa73PQ6brm3B5JBWx+askbOKWKrQYu5?=
 =?us-ascii?Q?pJCzj++csi75/UHfLY2yRKN3TKCeFLQL9512CDyy2PWqxfxIwt3ID7fyWT9Z?=
 =?us-ascii?Q?CuqyULUUo6Sd6kCu7TuXuivgAXvAxMjgkDTgmANLzSE9jGMk2fhD0EFd2J5Y?=
 =?us-ascii?Q?UrQbgBt6D7iRaIZZa4oQN5fD2ImI31AgaUMJVELFVPNxzqjlqMwaowfy3DDo?=
 =?us-ascii?Q?ogQv7HG4oYprKc0jgOHrs53GSSGeEkzoxXcJbFwPMLj5+eebhxgvHgPji4z3?=
 =?us-ascii?Q?8Nl1WVINeKn+Wt8M7QzC5u6HHd38b5aLpu+Gb9b5+3erZddnHrL1EyVNi7Cd?=
 =?us-ascii?Q?qmlI5QQHsOsxR4e0PbOUCpP0RPt5ASKlfr6VuQuTo+ea+/10VKddEHSoHmYn?=
 =?us-ascii?Q?vIEFVlAS04Y9VjJ4VUrSMNAd2qv8YlcyfPG4IMMqPF+Ya0Z/Y1QTb30+YFaz?=
 =?us-ascii?Q?7c3ngjZksWwmWVpf7xRuR+YN/fU/x1GotZSeoKauugLyzzxTk38j2E4STQKF?=
 =?us-ascii?Q?7T2Nmh0JEQvMy1jA/P0nwCtXRlf/e1WToUewgL8VsWrGlAdPr9cR3ZGXBLOD?=
 =?us-ascii?Q?M7bWux0h3ZZJZzikHIblN6WzbX/NlGVS4ovj65q+B3lupZN+wQcVfRuW9M5m?=
 =?us-ascii?Q?JySlBEohY+xVE+WyrseUzd5IXhPbfcbqBVLyrS6J9QKqJidUqJH7oc1HvX+C?=
 =?us-ascii?Q?WE+scVUg9GMTHNIMCOLp3bFkbRhz6WT2B5pnmT60gtEhqQF/NbwA/fNY8AgV?=
 =?us-ascii?Q?bbMqMEBxnySI9icvDKhKV00AeLTkCLV5X4KDcQewxkq5JJb8LQlCyObdP/JM?=
 =?us-ascii?Q?4ZiNuf/djD4YBMjp3pX6fnv8nbpeOniIBsiy2YnoiO+uTT/F1RxBIOsIMPhS?=
 =?us-ascii?Q?sMbjvXa/GykS35Qr7THtY8/tSQ+PkbbRbi/2ZKe5h6PtShJLeAoXmKx7pLMM?=
 =?us-ascii?Q?uTnc46kJm+ENc6Rg0Ud+uVzvQwEnJZo2JKVGZnPwth6XQlNqMJFV86xjTdRl?=
 =?us-ascii?Q?TkhaXDdNpQdpy/sxp7uK7doq5hDs6M1aTHFK+sRO/xRxSsexNC29v5Is5jVK?=
 =?us-ascii?Q?SPzcjbnAevf5ylNo6qq6sp+XLVE0QPyuq+wtnb1TUrdabKJ9l+sTo1vWE0Zj?=
 =?us-ascii?Q?nDP48YKmIZmjNFiNdfTQCMJbHgm+owMtKELRaBzWcJQ17as8mV0OT7Oi0jdR?=
 =?us-ascii?Q?QwHVkryma3LMdJS3+vc1pYyc0tCtW6xifp8xg/BceSBZ7zpTWw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dxdxO1SmlHnLrVOzTdUU/doq1/Sey8lEs/haNHTEkE2evz5cqPszuu2N0vUz?=
 =?us-ascii?Q?AXQKBbKaJomg/BLeeIt9hGUaFLDBfHPmuW1E2wkC3htmuTAD5T+1N5fslLTO?=
 =?us-ascii?Q?67phFfqNpTyxEv6enw5UKHWII8ResBy0GKw9b7D+OU5YUzOFj6JZWUdYWdUi?=
 =?us-ascii?Q?DKE1Mx9IuxRZ2zjAxD1VwlNZbQGUmVumvE0to9oUUMrQelQS9pdP3mDR8wx7?=
 =?us-ascii?Q?Jtwmj9jg9DaXZNwcNUAnPE7Gn7dpnhjz+BuzjmaAbUYeS5iDdTkWF6hNE3Vq?=
 =?us-ascii?Q?m//d2S4ULpVJSN41JBbPP3dVXz5G+JTAy1aocQtOKZYpHG9w3pFjfTt9GIEt?=
 =?us-ascii?Q?l85E3eqtdp1I93UE43Q5ZIdPx0mlhlYlkA9f+V19VLkx1mXbMTi9TBu8HEsG?=
 =?us-ascii?Q?JQ+9QUK7ipa/005SG4/96zPK4zYmkTAfvwvIK6mboC2jgE3AzuCMAvbnGY1T?=
 =?us-ascii?Q?iOMAO+bBmfDYbQuoqeKQYRmnVMTIBPhfcwFti1mrZQS/qhSh/9+2tJW8UhpL?=
 =?us-ascii?Q?QCPL/1Mfr4XygOqZQ5EXcaptj/F2If/iLTUG1OeMCjjMku1cDTSO0K5gUZ56?=
 =?us-ascii?Q?6Rg/Eli/2lEldh2k6Ku922EBPIHq+5iKNlEuKsQIfYJSzcpaEWfWfh+ae65C?=
 =?us-ascii?Q?oBQHubtuhgM9h1VXwV1gfXWomy6wi4BPD79eEJbR8Ny+ZAtcrvN7bBH6DOCl?=
 =?us-ascii?Q?x1DUi9FLPu0tzhAt6odcpHT6Zr8YJHyjVhqL0HYozP23m2qmV1bLPFVg5oe2?=
 =?us-ascii?Q?19x+4Yq2VI0qaMo+kJRnS9sSLnD3610pIpGo6ET+9DruMvNx6xjhigb9ncYR?=
 =?us-ascii?Q?Gu8piYLESMTONQ1aRivoNmVn7PR05YQzbjPnP8Vyra6znQJbJTwJjZIBi1V0?=
 =?us-ascii?Q?i1VF79C7NCBLZL0JxT0hxfLnNdSFjYpAlFYW5IVJbtg9mZTzIAd1bpmcUlW/?=
 =?us-ascii?Q?SSgmiTW+LASlNJM8h9v8odt1LIfLkIHHpRtrBXp2YgvGftlF/DwirNfGv8Ep?=
 =?us-ascii?Q?+EUvPJTug1HtShfqT9DCJhu3AakMJ3hz6jsksEk/QCfUum4ZCgBEZTfXJfVK?=
 =?us-ascii?Q?8EJkNm0mIMcV7X7kK2yaHQYQviZRCI92ImuMLRJ4RR1/NfbJORCF4ePVVnx6?=
 =?us-ascii?Q?nGRiOferH2IsAvnbcW6aRyw0K91s7Bq3vVL6+s6rhUlJubhy4t9lg1sAt4CT?=
 =?us-ascii?Q?xAV3BhEKfJueyly346Hbat78KELQYwPyVSMORU/9/t84ToBruRMGbl9Jcbav?=
 =?us-ascii?Q?DlVmw79g3NB/5zXB/qzITa0PvqXsHHQaAJ21MVJvr2bQTzdajou9uJGzNw8S?=
 =?us-ascii?Q?nhd6pwdGQlZYkyCtFa19MCjbpdGnxHD+dM+P+9WA1S/p4rPzf2JLLtl06ZJu?=
 =?us-ascii?Q?acoe93JEjFlvtqPvhO0IoKoEUzzRMdWDNga6UDOSsyb+JhNqDx6b2yZqjFaT?=
 =?us-ascii?Q?zOkdetnuVze0/hSPqLzZ4eBuhzbHLICy/Tng8UUYJtvDxBjOGKcF/YDtlNJ8?=
 =?us-ascii?Q?mw+G6u586JvThqby0RLY76Le6vGIqifjg8+M3cM4eaASUb5BKzHRaFmBFtm2?=
 =?us-ascii?Q?FfeyAiWonYYhlNAjXfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b472cf81-df00-47c6-2cd8-08dcdb881c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 04:28:01.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYYByIEqZ95KwGWdrLiGxZyTdT6qAQRMuRvSJ6mkkSNtA+9UWN9jaK0LRIQvjjdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, September 18, 2024 1:50 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.co=
m;
> linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FP=
GA
> configuration
>=20
> On Tue, Sep 17, 2024 at 11:16:08AM +0000, Manne, Nava kishore wrote:
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Monday, August 5, 2024 11:51 PM
> > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support
> > > for FPGA configuration
> > >
> > > On Thu, Aug 01, 2024 at 04:25:42AM +0000, Manne, Nava kishore wrote:
> > > > Hi Yilun,
> > > >
> > > > > -----Original Message-----
> > > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > > Sent: Monday, July 29, 2024 9:27 PM
> > > > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > > > robh@kernel.org; saravanak@google.com;
> > > > > linux-fpga@vger.kernel.org;
> > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > > > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface
> > > > > support for FPGA configuration
> > > > >
> > > > > On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrot=
e:
> > > > > > Adds sysfs interface as part of the of-fpga-region. This newly
> > > > > > added sysfs interface uses Device Tree Overlay (DTO) files to
> > > > > > configure/reprogram an FPGA while an operating system is
> > > > > > running.This solution will not change the existing sequence
> > > > > > When a DT overlay that targets an FPGA Region is applied.
> > > > > > 	- Disable appropriate FPGA bridges.
> > > > > > 	- Program the FPGA using the FPGA manager.
> > > > > > 	- Enable the FPGA bridges.
> > > > > > 	- The Device Tree overlay is accepted into the live tree.
> > > > > > 	- Child devices are populated.
> > > > > >
> > > > > > When the overlay is removed, the child nodes will be removed,
> > > > > > and the FPGA Region will disable the bridges.
> > > > > >
> > > > > > Usage:
> > > > > > To configure/reprogram an FPGA region:
> > > > > > echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load
> > > > >
> > > > > IIRC, last time we are considering some generic interface for
> > > > > both OF & non- OF FPGA region, but this is still OF specific.
> > > > >
> > > > At AMD, we exclusively use OF for FPGA
> > > > configuration/reconfiguration, utilizing
> > > overlay files as outlined in the fpga-region.txt documentation.
> > > > However, some devices, like dfl.c those relying solely on the FPGA
> > > > region, do not
> > > use OF.
> > > > For these non-OF devices, should we expect them to follow the
> > > > fpga-region.txt
> > > guidelines for FPGA configuration/reconfiguration?
> > >
> > > I assume it is Documentation/devicetree/bindings/fpga/fpga-region.yam=
l.
> > >
> > > No, Non-OF devices don't have to follow the DT binding.
> > >
> > > > If so, it may be advantageous to develop a common interface for
> > > > both OF and
> > > non-OF.
> > > > If not, it might be more appropriate to establish distinct
> > > > interfaces to cater to their
> > > specific requirements.
> > >
> > > I think each vendor may have specific way for device enumeration,
> > > but that doesn't mean we need distinct user interfaces. For all FPGA
> > > devices, we should avoid the situation that the HW is changed but
> > > system SW knows nothing. So the common needs are:
> > >
> > >  - Find out and remove all devices within the fpga region before
> > >    reprograming.
> > >  - Re-enumerate devices in fpga region after reprograming.
> > >
> > > I expect the fpga region class could generally enforce a flow for
> > > the reprograming interface. And of-fpga-region could specifically imp=
lement it
> using DT overlay.
> > >
> >
> > To address the vendor-specific nature(either of or non-of) of device
> > enumeration in FPGA regions, As you suggested, we can develop a common
> > programming interface that abstracts these vendor-specifc differences.
> > This can be achieved by integrating vendor-specific callbacks(ex: of
> > and non-of) for device configuration, enumeration and removal to fpga-r=
egion.
> >
> > I have outlined the top-level framework changes here:
> >
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index b364a929425c..7d4b755dc8e0 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -213,6 +213,7 @@ fpga_region_register_full(struct device *parent, co=
nst
> struct fpga_region_info *
> >  	region->compat_id =3D info->compat_id;
> >  	region->priv =3D info->priv;
> >  	region->get_bridges =3D info->get_bridges;
> > +	region->region_ops =3D info->region_ops;
> >
> >  	mutex_init(&region->mutex);
> >  	INIT_LIST_HEAD(&region->bridge_list);
> > @@ -257,17 +258,46 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
> >   */
> >  struct fpga_region *
> >  fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> > +		     struct fpga_region_ops *region_ops,
> >  		     int (*get_bridges)(struct fpga_region *))  {
> >  	struct fpga_region_info info =3D { 0 };
> >
> >  	info.mgr =3D mgr;
> >  	info.get_bridges =3D get_bridges;
> > +	info.region_ops =3D region_ops;
> >
> >  	return fpga_region_register_full(parent, &info);  }
> > EXPORT_SYMBOL_GPL(fpga_region_register);
> >
> > +static int fpga_region_device_open(struct inode *inode, struct file *f=
ile) {
> > +	struct miscdevice *miscdev =3D file->private_data;
> > +	struct fpga_region *region =3D container_of(miscdev, struct
> > +fpga_region, miscdev);
> > +
> > +	file->private_data =3D region;
> > +
> > +	return 0;
> > +}
> > +
> > +static long fpga_region_device_ioctl(struct file *file, unsigned int c=
md, unsigned
> long arg) {
> > +	char __user *argp =3D (char __user *)arg;
> > +	struct fpga_region *region =3D  (struct fpga_region *)(file->private_=
data);
> > +	int err;
> > +
> > +	switch (cmd) {
> > +	case FPGA_REGION_IOCTL_LOAD:
> > +		err =3D region->region_ops->fpga_region_config_enumerate (region,
> > +argp);
>=20
> Not sure "void *args" is a proposal or something yet to be decided.
> I think we should try best not to give up parameter type and have a clear=
 API
> definition.
>=20

I agree fixing the parameter type is necessary, and I will work on
Implementing this change in the RFC. Following our discussion,
If any additional modifications or clarifications are required,
I will ensure to incorporate them in the later stages.

> > +		break;
> > +	case FPGA_REGION_IOCTL_REMOVE:
> > +		err =3D region->region_ops->fpga_region_remove(region, argp);
> > +		break;
> > +	case FPGA_REGION_IOCTL_STATUS:
> > +		err =3D region->region_ops->fpga_region_status(region, argp);
> > +	default:
> > +		err =3D -ENOTTY;
> > +}
> > +
> >  /**
> >   * fpga_region_unregister - unregister an FPGA region
> >   * @region: FPGA region
> > diff --git a/include/linux/fpga/fpga-region.h
> > b/include/linux/fpga/fpga-region.h
> > index 9d4d32909340..725fdcbab3d8 100644
> > --- a/include/linux/fpga/fpga-region.h
> > +++ b/include/linux/fpga/fpga-region.h
> > @@ -9,6 +9,20 @@
> >
> >  struct fpga_region;
> >
> > +/**
> > + * struct fpga_region_ops - ops for low level FPGA region ops for
> > +device
> > + * enumeration/removal
> > + * @region_status: returns the FPGA region status
> > + * @region_config_enumeration: Configure and enumerate the FPGA region=
.
>=20
> region config could be a common existing operation, fpga_region_program_f=
pga().
> So maybe only enumeration is needed?
>=20

I agree configuration and enumeration can be handled separately. However,
for some vendors, pre-configuration details such as port IDs(AFU) and
lower-level connected device information needs to be set before configurati=
on.
To accommodate both vendor-specific pre and post configuration (enumeration=
s),
I chose to use a single API for handling both FPGA configuration and enumer=
ation.

> > + * @region_remove: Remove all devices within the fpga region
> > + * (which are added as part of the enumeration).
> > + */
> > +struct fpga_region_ops {
> > +	int (*region_status)(struct fpga_region *bridge);
> > +	int (*region_config_enumeration)(struct fpga_region *region, void *ar=
gs);
> > +	void (*region_remove)(struct fpga_region *region, void *args); };
> > +
> >  /**
> >   * struct fpga_region_info - collection of parameters an FPGA Region
> >   * @mgr: fpga region manager
> > @@ -26,6 +40,7 @@ struct fpga_region_info {
> >  	struct fpga_compat_id *compat_id;
> >  	void *priv;
> >  	int (*get_bridges)(struct fpga_region *region);
> > +	struct fpga_region_ops *region_ops;
> >  };
> >
> >  /**
> > @@ -48,6 +63,7 @@ struct fpga_region {
> >  	struct fpga_compat_id *compat_id;
> >  	void *priv;
> >  	int (*get_bridges)(struct fpga_region *region);
> > +	struct fpga_region_ops *region_ops;
> >  };
> >
> >  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> >
> > In this approach, we utilized an IOCTL-based user interface, but it
> > doesn't have to be confined to IOCTL. We can also use sysfs or
> > configfs, or other appropriate options as we finalized on it.
> >
> > This call-backs approach works for both OF and non-OF devices.
> > If this aligns with your expectations, I can do the necessary changes
>=20
> There are still much to discuss, but yes this is a good start.
>=20

Thanks for providing the quick confirmation will post RFC soon.

Regards,
Navakishore


