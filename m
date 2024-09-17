Return-Path: <linux-fpga+bounces-711-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C997AF95
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Sep 2024 13:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C681F21EB6
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Sep 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DAF174EEB;
	Tue, 17 Sep 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PXNzDocn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EA167D98;
	Tue, 17 Sep 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571774; cv=fail; b=unlaYlZaHqQRcdV9XHxn5JKoHgnaFv6Vg5H/qMmHfZy9D/XDOhcvFhx10CnczKtpavgbtnxPsp1EM10ou9NsAEsjSykJ34dAamd+uIjw3uWgG+KLGiW4M21qVRrDyY4pUeXBfI7kr3IHJCjz1RLlXC6TpovAvZluyBq/GsVPziw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571774; c=relaxed/simple;
	bh=Jhax/UD1hQZuItCF7u2XX1vc+PK42IuZBoxSzUn53pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pp4I0Sb0Mk+MZP8LDRNhhUOkhD2niH4MAtXoAe8wC75i0Q+QZV/kSbOkJZk9Xw/6+Pxd+uZ5k8nPmTpHHrEZbPdY3npkdD9Dy7biOrWm3+D1fYvheEODKwLoeb6npIWWM//ohXttn9+BCyUZfwSzU7sSeZf7Cl21d2TFUXQMwok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PXNzDocn; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsFGZ+xuHQr8rXS7MQ6qMucprIWAIfw9aLwL2EzWPF7wLbhGzv867roluzALc+V41ENl9pRXO6G0RWYsnyIkf/T66nqNITuXgxNsNIPBX9ZW0mikNqk7f3xKm4Yj7t+Yn1PHc/9ZJ4v0B11s/LT4Y05aQTf0Ln9EtCY8C8y1X7JRULgJnUvQqw7IvZmqPIGu+RhnsPiFl0ZgPAHbOKayK8ZFy07f3Sia55KmKXLoWmHPbDCrm08LKMxA/gm7lumebr8OB/IQkJ7W2C6uuLdlIwCO/3IvallfYEXfzyTyHLlqfZtk8uss550iUDKBRfHdKcC6uLA+fRpmlknw7SJtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enE6W/ltZdTBzx+7G7ybLiqaee4hXBbw1e9mwHERPbo=;
 b=RPz84S9oS2hBu09Z/W3HZhMNMzBRPdhmVX61fw87oFe8nI6a2i5MKXEPo1XFsqw1ec3Q5weXVAP1e+ZQw0FNcYNMTLBmi/j2NI/LqOqn4NlIt0Xb3IUBzxxmg1KYCXehB7w3xPFEp/uJLFmOug6ouR/T4Fm/L4iFvy2fmyX/T3ju3TQpmSlqLCnrBYK6FKiyT2kowv1vgAaBrDGDl3+wfZ/fl9MUP8l4CA47fP0DpvAu/rVT35beQsttV6KW5vDPKIbAcuv0GchDbwk/0QAiPw62XS/2MnUt7grbKfzR+qh52reWfidBcNDacBxtZfJsqbaAWpA2TzHpvknfG7VXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enE6W/ltZdTBzx+7G7ybLiqaee4hXBbw1e9mwHERPbo=;
 b=PXNzDocntS1uPJ1M1vVk/8JW3bBc6Hib0UvX8Cp9RjjqmYst1CV97NtMwEtUK7v9mYufAPSaJrjURATNzSn/PP1LAT7FPgx9tR/HZFr58kDCSzz1HiAiD3BWCfNr6qQfk7tfp87ehG0i2Q5AifHe1cE6KEoV5HfpEmezF4dlUTg=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Tue, 17 Sep 2024 11:16:08 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 11:16:08 +0000
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
Thread-Index: AQHa3yZuwBfgoAWoa0yxdButTACHTLIN4ZUAgAPvPVCABzk2AIBDFq6A
Date: Tue, 17 Sep 2024 11:16:08 +0000
Message-ID:
 <DS7PR12MB60702067EE3B40A4256F90D3CD612@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
 <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>
 <ZrEX9HlAOlUtgnTj@yilunxu-OptiPlex-7050>
In-Reply-To: <ZrEX9HlAOlUtgnTj@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|CH2PR12MB4310:EE_
x-ms-office365-filtering-correlation-id: 1c3fd813-c82c-4ebb-4290-08dcd70a211b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mCiFQA4W8n2th9kKf8O6JcqqSjBbutgA660bCrIO8UjZihawoQFyyNgwdTpR?=
 =?us-ascii?Q?gfulcn937daEDa7aL8Lqs1tOe7SKUc9UUX5+Plri8U+JLSTeo09yNVKzJ0X+?=
 =?us-ascii?Q?J8RNH360BAeT9D4Ge8PHSmFXhWYVU5XGEBEquGPHRVqpKa0TZudyzoY5RJ6h?=
 =?us-ascii?Q?NrodGD9T26CiIUxLJHxFEKnP2o4LgIdL+1Wz4933yze3mbR812YQZoGacZLy?=
 =?us-ascii?Q?gkVHHjo9YLLagQIJiDx7dzQpJwB6ahFcnR90fnXl9vQb61txitAoE6skWMfT?=
 =?us-ascii?Q?ssj+APlBEvHz/osdH4u4hebcL7TPODewRdnkbDx7spsMxauDrqQoO0lfwiXm?=
 =?us-ascii?Q?6FltVK8teYV5JsFIUOo62nbj9t1vLwKs8+jnpHrDBBPRHHnYA1AH7sBv7vi/?=
 =?us-ascii?Q?bkdLhCBiwpEDv24HeP95SgIDsaCKMFDyqcbgfgwRKF+SkW4L3Xnro8WS8m4x?=
 =?us-ascii?Q?XIEwI5E+RfS6NOMt7QyZp7DcI64ePVv1b3laK5/rZAHao7MgT3IuGzI7psxQ?=
 =?us-ascii?Q?62eYO6UV2rn0GrWJRnrTI6+cMO8PJCr1IGo1is4UMLZeb9vTfD4GoFL84kuZ?=
 =?us-ascii?Q?7pQc2pk5VLAggT7/p2h1eIXnSv5RLQR4kYAREwjXOWoK43fa+p8+vdXHpVyV?=
 =?us-ascii?Q?54brFxLhxrV50W0qEejzon9j5hsYAS7+uwcCIon/xljAAZuSU6JxQKhrrdWh?=
 =?us-ascii?Q?QXcEfjcrpK4x/CQ2jWtKT6p0kS0OYPGPf8AFjxIc7IwO7WNne8Y7VYuoIh05?=
 =?us-ascii?Q?CO/92f+DBtSSBGhr2jSw9Zb6JXYR3rOXVJI7HrnKAl82tYUj7cVtFg43fcHI?=
 =?us-ascii?Q?E2DtvZr0BlplSOMIFqgEVrPFjKzU4cz0hZFy4jiNpfAv6LAyhAJnUC9ODwRv?=
 =?us-ascii?Q?KV0UtcFHTq34ufjiYGLtXmA/YPA/OMm8/DYq0CM6AcjteoEdaD50+A4ibbMO?=
 =?us-ascii?Q?iSxFefMr4Vt/oj9W8BOTa0migLN1IJZF/9jpa+Hu/POnCKFoh+pGbREBowCd?=
 =?us-ascii?Q?b2xIweozGxJQ23YDyUSGPGmbJ5OdomYfh28868yNbi4rPjGoBpx4uS51ARZD?=
 =?us-ascii?Q?DeqERk+1ybNbJgVfVPt/KJEyBj+VtqJvUSR5b/BmJXKxhBNVvs1RI9P4MljQ?=
 =?us-ascii?Q?eOBrUFfvt5CFk0IKGw9wrRNkHigkMN6foAr5p/ISoqSHnZ80TQPm8s/czv6s?=
 =?us-ascii?Q?ss3u+XpMGh2ba7LRumUcrqanoPQQEDHoNRgeDAf6ofqDjdMCw8wdPp8vY+7x?=
 =?us-ascii?Q?VDFUQwftNOmBaTBarPKgVW84ZlUB2dS0f5NAiVkAbr0wQLaqsgHTXjGinsHn?=
 =?us-ascii?Q?0KwKfvfyVRD9NvXAcpUjX36O+S8jKOKWOKgmMkDYePHY+dzIi2+qjIUGA8kR?=
 =?us-ascii?Q?9ZNFiYY1kNbL8kXk8+1Rr4h1xuXUJSMr1WYjSvIlGXxuGuGKqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?je2LMdoZS7ha7/xOIFKNkeQdNRS6eTNJHXoYDn50ASOtvkuVyw/CTAOuzozJ?=
 =?us-ascii?Q?6DezHExME3gJO25pSHbvVI7pRMIXWmfnFgZ2RGHr4bYEHgH5Rd2k8wqo20/W?=
 =?us-ascii?Q?odIpBKCxtiWX15v9wQIwHqYsXMCyi0XrxcPSa1tk+OYuKSPfhRvEHq8n/uFJ?=
 =?us-ascii?Q?O9OdYY/qJV7zbbi0hYiVugIA5DNHknDzRgEiJ+cnqmxj9mkayxmd6R2SuxD/?=
 =?us-ascii?Q?Aoc7CYrOGS7zan4wiKKXHH4qnwum+zJsz/Crh2JiuWGyEXjdo+FmlRJlUdbT?=
 =?us-ascii?Q?Ka/e7EX5ZoVLrUwlGOz0lLCzWyTO8z96ntE6aAzyqho7JLI5nmj+QnFgkUD3?=
 =?us-ascii?Q?SPAYL8QMk0cATBA8rC8PKQAAfXOvsaMXv0bk3N58Z4hm2YssI1utzaLxNtCb?=
 =?us-ascii?Q?fOO3JoF/XjMQtYSr0k0teO4qu9e1BmmaxbzMhKutZtH8ljAojiiBQOs9WCmk?=
 =?us-ascii?Q?3mf2K64h47blpWdWr0mhefGXyXkFyDvHay1w7fQwo2AFfKc30/sXvslfzhvY?=
 =?us-ascii?Q?ok+IQf88tuOHMPv71Hqby6ueFuzThomuQ6Dxs6NJgpIXUaJ+CVHuUQOg0siM?=
 =?us-ascii?Q?JLwrLcXoEcpq5vuNFuLAg6GzG+jspyq+yPLm3cQEwguqkPZP0V4emXI18rzL?=
 =?us-ascii?Q?5CmK0DCJ3k4mxP8V+L6MSYIo1v/AAUyWTxlEiq4woK4r4oP04mIM+9UJTNYz?=
 =?us-ascii?Q?nZqf++ghBly/BlzlCSOzfcbtmSpbDPD2bXsp8EpzOxrk7CMHQ3tN61IOhu+R?=
 =?us-ascii?Q?Cp/RL0Uej5JF4g/o0CfXDgnvdSDanE1AEpCOwGSAchvVBSxDGUOZPnWQlkmg?=
 =?us-ascii?Q?guH96YGZA97qDDdJROA/r4FaWr3/dkDn8VysfY8Xx4x6l8lLRldyUdMbfRLX?=
 =?us-ascii?Q?yqSLuxwuVok0qpoTYUKWo3MJRNzTvq1+h5dAUyugKQCwuJ6aVK522BUsax33?=
 =?us-ascii?Q?ZnxaQYYA866otZwi09eCaSb7DVZ3fmDgA4OTi4fJl/uovMX0lyPBKv9HeirL?=
 =?us-ascii?Q?5EojmeqTMUJ/yQcNK+5oXO1kgjECelIQykF2m19wxqcUm1cq4QokAgEGwjjn?=
 =?us-ascii?Q?iQx4vySIrxw66UEuEMx32BgjHRj+kfm3QsSFENUTMXsCEeAFoRAvk5E5spyw?=
 =?us-ascii?Q?+7xlNsUo0Y2b4bFp+ilCnyQZ7J2jXfRPA2LuKqSeLY2JQ+wCbuFogeU5Qyjj?=
 =?us-ascii?Q?tAcmqnU30r8ZZe8HRo5rMEmolzCs64zI8rJiISqpyTp7LvqWHz0D/jUJVYv+?=
 =?us-ascii?Q?PmYF9PIh/EDA+ngT0gTgqi5ONTWIetA9+7rciGFbbTRHe7z3pucctet02Ndp?=
 =?us-ascii?Q?NuojUR74m2ZjAAa1srEXx04L2ngJn12Uv+FvSjlh7XWmrVmdewV7QX5E7O8v?=
 =?us-ascii?Q?fHoNaRWMUoYsKYsAdW6JYMrocDZABhluKucbfFU+Xw/qDEMS6O2wuAT4+0Kg?=
 =?us-ascii?Q?tgj5ckqtWEze5akqN4VUcPeb6lLs/27TgHwI8vG7orMnD2QDACfBBMRBqtvz?=
 =?us-ascii?Q?OKeyi1NwrVJ2q99h2nHzYnV7HfS5DuvPZYX4mZaQxUrjpTNgyvfJEXYixT/R?=
 =?us-ascii?Q?YPSdXgof+sLY4tPIcwg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3fd813-c82c-4ebb-4290-08dcd70a211b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 11:16:08.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FViNmFktXcwZsokebfLSZczZfX6jnwkt7gE17efSOFVJ8XmyG2fdJ/KZI5ocetg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

> -----Original Message-----
> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Monday, August 5, 2024 11:51 PM
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
> On Thu, Aug 01, 2024 at 04:25:42AM +0000, Manne, Nava kishore wrote:
> > Hi Yilun,
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > Sent: Monday, July 29, 2024 9:27 PM
> > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org;
> > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support
> > > for FPGA configuration
> > >
> > > On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrote:
> > > > Adds sysfs interface as part of the of-fpga-region. This newly
> > > > added sysfs interface uses Device Tree Overlay (DTO) files to
> > > > configure/reprogram an FPGA while an operating system is
> > > > running.This solution will not change the existing sequence When a
> > > > DT overlay that targets an FPGA Region is applied.
> > > > 	- Disable appropriate FPGA bridges.
> > > > 	- Program the FPGA using the FPGA manager.
> > > > 	- Enable the FPGA bridges.
> > > > 	- The Device Tree overlay is accepted into the live tree.
> > > > 	- Child devices are populated.
> > > >
> > > > When the overlay is removed, the child nodes will be removed, and
> > > > the FPGA Region will disable the bridges.
> > > >
> > > > Usage:
> > > > To configure/reprogram an FPGA region:
> > > > echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load
> > >
> > > IIRC, last time we are considering some generic interface for both
> > > OF & non- OF FPGA region, but this is still OF specific.
> > >
> > At AMD, we exclusively use OF for FPGA configuration/reconfiguration, u=
tilizing
> overlay files as outlined in the fpga-region.txt documentation.
> > However, some devices, like dfl.c those relying solely on the FPGA regi=
on, do not
> use OF.
> > For these non-OF devices, should we expect them to follow the fpga-regi=
on.txt
> guidelines for FPGA configuration/reconfiguration?
>=20
> I assume it is Documentation/devicetree/bindings/fpga/fpga-region.yaml.
>=20
> No, Non-OF devices don't have to follow the DT binding.
>=20
> > If so, it may be advantageous to develop a common interface for both OF=
 and
> non-OF.
> > If not, it might be more appropriate to establish distinct interfaces t=
o cater to their
> specific requirements.
>=20
> I think each vendor may have specific way for device enumeration, but tha=
t doesn't
> mean we need distinct user interfaces. For all FPGA devices, we should av=
oid the
> situation that the HW is changed but system SW knows nothing. So the comm=
on
> needs are:
>=20
>  - Find out and remove all devices within the fpga region before
>    reprograming.
>  - Re-enumerate devices in fpga region after reprograming.
>=20
> I expect the fpga region class could generally enforce a flow for the rep=
rograming
> interface. And of-fpga-region could specifically implement it using DT ov=
erlay.
>=20

To address the vendor-specific nature(either of or non-of) of device enumer=
ation
in FPGA regions, As you suggested, we can develop a common programming
interface that abstracts these vendor-specifc differences. This can be achi=
eved
by integrating vendor-specific callbacks(ex: of and non-of) for device conf=
iguration,
enumeration and removal to fpga-region.=20

I have outlined the top-level framework changes here:

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c index =
b364a929425c..7d4b755dc8e0 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -213,6 +213,7 @@ fpga_region_register_full(struct device *parent, const =
struct fpga_region_info *
 	region->compat_id =3D info->compat_id;
 	region->priv =3D info->priv;
 	region->get_bridges =3D info->get_bridges;
+	region->region_ops =3D info->region_ops;
=20
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
@@ -257,17 +258,46 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
  */
 struct fpga_region *
 fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		     struct fpga_region_ops *region_ops,
 		     int (*get_bridges)(struct fpga_region *))  {
 	struct fpga_region_info info =3D { 0 };
=20
 	info.mgr =3D mgr;
 	info.get_bridges =3D get_bridges;
+	info.region_ops =3D region_ops;
=20
 	return fpga_region_register_full(parent, &info);  }  EXPORT_SYMBOL_GPL(fp=
ga_region_register);
=20
+static int fpga_region_device_open(struct inode *inode, struct file *file)=
 {
+	struct miscdevice *miscdev =3D file->private_data;
+	struct fpga_region *region =3D container_of(miscdev, struct fpga_region,=
=20
+miscdev);
+
+	file->private_data =3D region;
+
+	return 0;
+}
+
+static long fpga_region_device_ioctl(struct file *file, unsigned int cmd, =
unsigned long arg) {
+	char __user *argp =3D (char __user *)arg;
+	struct fpga_region *region =3D  (struct fpga_region *)(file->private_data=
);
+	int err;
+
+	switch (cmd) {
+	case FPGA_REGION_IOCTL_LOAD:
+		err =3D region->region_ops->fpga_region_config_enumerate (region, argp);
+		break;
+	case FPGA_REGION_IOCTL_REMOVE:
+		err =3D region->region_ops->fpga_region_remove(region, argp);
+		break;
+	case FPGA_REGION_IOCTL_STATUS:
+		err =3D region->region_ops->fpga_region_status(region, argp);
+	default:
+		err =3D -ENOTTY;
+}
+
 /**
  * fpga_region_unregister - unregister an FPGA region
  * @region: FPGA region
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-reg=
ion.h
index 9d4d32909340..725fdcbab3d8 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -9,6 +9,20 @@
=20
 struct fpga_region;
=20
+/**
+ * struct fpga_region_ops - ops for low level FPGA region ops for=20
+device
+ * enumeration/removal
+ * @region_status: returns the FPGA region status
+ * @region_config_enumeration: Configure and enumerate the FPGA region.
+ * @region_remove: Remove all devices within the fpga region
+ * (which are added as part of the enumeration).
+ */
+struct fpga_region_ops {
+	int (*region_status)(struct fpga_region *bridge);
+	int (*region_config_enumeration)(struct fpga_region *region, void *args);
+	void (*region_remove)(struct fpga_region *region, void *args); };
+
 /**
  * struct fpga_region_info - collection of parameters an FPGA Region
  * @mgr: fpga region manager
@@ -26,6 +40,7 @@ struct fpga_region_info {
 	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	struct fpga_region_ops *region_ops;
 };
=20
 /**
@@ -48,6 +63,7 @@ struct fpga_region {
 	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
+	struct fpga_region_ops *region_ops;
 };
=20
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)

In this approach, we utilized an IOCTL-based user interface, but it doesn't=
 have
to be confined to IOCTL. We can also use sysfs or configfs, or other approp=
riate
options as we finalized on it.

This call-backs approach works for both OF and non-OF devices.=20
If this aligns with your expectations, I can do the necessary changes
for one vendor specific interface (of-fpga-region.c) devices and submit
the RFC patch shortly.


Regards,
Navakishore.

