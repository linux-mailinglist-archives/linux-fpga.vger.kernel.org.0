Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5334E30E9BE
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 02:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhBDB4T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 20:56:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:44912 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhBDB4Q (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 20:56:16 -0500
IronPort-SDR: tC+LTUL2Q4y116HvgyNx2XTXsmnG45umzfQ3ge3jT4e1Jje9ow0yr1WRfLzJB5F+iv4kykB11s
 spRs/BiMMF6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242662997"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242662997"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 17:55:31 -0800
IronPort-SDR: mE4Fgxi8Y2+l3L6Nm6Du/1Pbod5qsAxEXNgObThgAh2LUQSk/0saSHZT/WpnwTi43hadYSjnKQ
 cpHnk00j2fow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="480643918"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 17:55:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:55:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 17:55:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 17:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILY2/kWBmBJrZU7NvFTDM2y/wlhQoMUf8PjyfU2nkaZc6Pz6YFn//U0evERqq1SCN7e4ui5cG+0NteR4dbxmaa1h8NNoQFBWGpenalYdzeqfr/Zoh004NpFTTNI1lyh6QYLaq9QmL+Qiym2XhHfRp3z+GyN4+yGQGZUPGTQ9BCZztpE2Q8IZ9MOEJhDnIeVOEMcQ2AdXcJnpXmjILDwy4RF1RQioNbMwJYw7/XvzvLOO924FqBVwzA/N4788YjYEtM8PvbSibhUcNIQ6NcSdbXUpxETAr3TDij2+zX+GQKigivEdnBI1wmBrLLEXqow+Kah4B8XgjhBbGv0FQQgIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKk5D2Qk3xvijL16isL46xmuTcB7IJ/RSeI88P2UZPg=;
 b=lfJFkbjE3FhyORlXIb6O8FNkMwaGaxk3g0RlOK90G+NMXeSKr/Xi+dMXCq04RAQS7cqH/kSHJ3rvgBXO9AuDzMHGgCntMJuJWX5xvqN6xR22Tdf0UBEv8OMrWeXf2/bemUWt0SYm/6X5WimRk8LJAhbFgOKb4LR/KfI6JlO1boHh65q7PrIgivb1UlzUnm8FdGFnMEbQgzgkTGGDh9/plD9JtUmapJ0CchPhK7sq9IE1C65+w3tolUS+SmZWmR9vJYqFZdjpN3JONYcnbk9fpygiC05Kp6eSkJqL2II1gUx2t0GW2ydJtOhdTsbTNvcd/T/deudS3JAS/x0psIqMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKk5D2Qk3xvijL16isL46xmuTcB7IJ/RSeI88P2UZPg=;
 b=iQSQKoDUtiUUlo/SKNsrgNNuh9nLCdldsIcb7jwgQsr2O1GjlfowHIgJNdRrIOe2OIJWtbup6WMJNvp2Pfu9jxNV0cNs0dsIndP4lL+RgF3lnlhJWYc4wiuiV64SCRhIMcBgyEah5uxMQOw+SI+848HfCYAM2P1cNszmmkiUJHo=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3657.namprd11.prod.outlook.com (2603:10b6:5:143::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Thu, 4 Feb
 2021 01:55:23 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3805.029; Thu, 4 Feb 2021
 01:55:23 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHWjSD4LeMXUYhU00yzPOyYE3T3saltlsAAgNiPhQCAANXVMIAA5ZOAgAAGsoCAACpaYA==
Date:   Thu, 4 Feb 2021 01:55:22 +0000
Message-ID: <DM6PR11MB38197E81243A179AED35F20C85B39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com>
 <DM6PR11MB3819BC4BFE16A9CBE185EB1185B49@DM6PR11MB3819.namprd11.prod.outlook.com>
 <25ada056-e591-4a6d-2e0e-704b099d00bf@intel.com>
 <alpine.DEB.2.22.394.2102031504300.1186805@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2102031504300.1186805@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5601a63-25e6-4915-aef0-08d8c8afef2c
x-ms-traffictypediagnostic: DM6PR11MB3657:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB365702C152765DF1CF6D534385B39@DM6PR11MB3657.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BawiIaCBOC91Nlj46bRq+DRBPsR8GJ5cQRsD5i29J06aDDUa9jdfcXlWgMleNrc50jsyez6RlF7ON+jCnP1PT9xscmHV8LCIdsNqxW7v6pIHV0nC/X1VMkReMmgDMUEP35sP0MaEV+h0AUzWTqeNJ6zqQpVcV+gTFSPpdrdVKUw3U6F+drT7nPd8/rQAhuqrp2Gl/uSeDIvm+PnjfIsUgURQ+1v0rV5cXDOpCMyDbZifqHsJ2rlaaJxDB9d6+TrPcaamIRWxcvY1k5FweO7pKhfDnr3d//gI3I0ytKjbSN5k5iYMepSj+KrU/TY/KQFZlkt+ZNix5FVuIQm3cxHmWcWKxhm4GSJRDW9UjZGl9dXAYxTBg9iGhdG8R6xHKKUh7ziweTxFCDuQuqXmIbWGK8/0+vOr1Zn0xMPZeUD1GrTyuWzkoCoBFc9Mx3T4Y26Zrr8VkVf344Enu6XWSovkpnJ96vBNxui7mXzJgHSkB1yAa+uphyjS6t8XDo2Ef5PdAU74UTYwHHRMFLiTfQr2tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(26005)(53546011)(110136005)(8676002)(76116006)(19627235002)(71200400001)(5660300002)(186003)(54906003)(8936002)(6506007)(478600001)(33656002)(86362001)(66476007)(6636002)(7696005)(316002)(66556008)(52536014)(66946007)(83380400001)(9686003)(66446008)(2906002)(4326008)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M3gJGMvqanCqd9atL7thIvMIJJ95W283XI5YfXsKoq47di4bEDg8Zzw+E5Y8?=
 =?us-ascii?Q?6vCam/10nApsTbxFAjwMC8TXY8p3KvtpX6R508LceOxOKEuXkJU02k+xaBUr?=
 =?us-ascii?Q?P9alNkshE8fZHj9Yazy7niwWj2+BZgQkOjRwtSYTxoeqDuS+nn2EhUzliZkt?=
 =?us-ascii?Q?HWDdzFOHGtYTfQC5I8VraPHMv11ERtNRfVEGEbnl6WOXKCuZ8Rg9IeSRnrRd?=
 =?us-ascii?Q?aov1pD2klrv5gmzzf5GzbvM8T4pQqWjm8NBLwlts2DdhkvZ0a/8pK4TNA+3W?=
 =?us-ascii?Q?SQN8DGY2vWZdK1l6PC2vE6E6BKb/EjqMtIr9obk28sZzBQSj0BMIjSwynnY+?=
 =?us-ascii?Q?Seckne2fPUXUO5D4CzCYs8NgL+5VJ0F18+hnYknnhOQIrVo32x6itlDvNUjj?=
 =?us-ascii?Q?BjQBcxMRdVcbZQwfeWF7eKCDZbEUUxZOrCxS/J8W/NhIz1ToiDTiKLGbD+V3?=
 =?us-ascii?Q?XlgLNL5lUpDLp0/+dRgC1E12bH77uNiO+NXJpOiDtfmw0ra9tx/jGtflGt7b?=
 =?us-ascii?Q?JdFfZEarWmhwBQiQkRwqAzKkGBYeuD3fJcuQPMTd4ng+J76ebnX3UJ16rxNW?=
 =?us-ascii?Q?hipBx4JY7GbJbihlkpe2ymhJq2tRCAspwh97vI9k6cypz7DH0qfeIMsfW8G4?=
 =?us-ascii?Q?BD0D6YykeARQjdiMzsQ0Gn3bKqdJ3UDmM3TbOHZ0QdAu7yhbiVSWabSUJlnn?=
 =?us-ascii?Q?AuURncgXVsV2afvKMoOqkCqyMWxTyqvJZ6BOcvbYKIcxMBOT2wibptf3WR8m?=
 =?us-ascii?Q?iRLdSmJbFbKffPB5Bom4Gv30jIQVrXI+h3TdNTRFqk/DrlOKHhP1RrfggO93?=
 =?us-ascii?Q?CmJ5atUFV4fJM0srDruJzbg7lwcszw/M7ijUsv57edTbgWgJ54hYmllrUXhY?=
 =?us-ascii?Q?nBNF56pFo54wUp3Z2PTptRONq0N0O9zHomLbvzuqFMagBv96BQqqpLYg3ekm?=
 =?us-ascii?Q?vaRzO2QYSiZIernfM+OuXKQr8kuiBTsL+3djsCvvvoGXAq+dPfK/GEJxwU+c?=
 =?us-ascii?Q?E2FpbTTdQqNFBD8mlucDjxaeubY4SvJ5SQF41J0Y8jmZztSUrV53ib2Saw1J?=
 =?us-ascii?Q?eClGAtvK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5601a63-25e6-4915-aef0-08d8c8afef2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 01:55:22.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soXW0/x+MuXE48KgCE/EuL7KPUa6vhOX0hPUVTI6x8VgKgUpMYhXkzX8hyi+VWaVXpQp55x00Tj88JZgL5ZPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3657
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Wed, 3 Feb 2021, Russ Weight wrote:
>=20
> >
> >
> > On 2/3/21 1:28 AM, Wu, Hao wrote:
> >>> Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
> >>>
> >>> Sorry for the delay on this patch. It seemed like a lower priority pa=
tch than
> >>> others, since we haven't seen any issues with current products. Pleas=
e my
> >>> responses inline.
> >>>
> >>> On 9/17/20 7:08 PM, Wu, Hao wrote:
> >>>>> -----Original Message-----
> >>>>> From: Russ Weight <russell.h.weight@intel.com>
> >>>>> Sent: Friday, September 18, 2020 2:32 AM
> >>>>> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> >>>>> kernel@vger.kernel.org
> >>>>> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun
> <yilun.xu@intel.com>;
> >>>>> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
> >>>>> <matthew.gerlach@intel.com>; Weight, Russell H
> >>>>> <russell.h.weight@intel.com>
> >>>>> Subject: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
> >>>>>
> >>>>> Port enable is not complete until ACK =3D 0. Change
> >>>>> __afu_port_enable() to guarantee that the enable process
> >>>>> is complete by polling for ACK =3D=3D 0.
> >>>> The description of this port reset ack bit is
> >>>>
> >>>> " After initiating a Port soft reset, SW should monitor this bit. HW
> >>>> will set this bit when all outstanding requests initiated by this po=
rt
> >>>> have been drained, and the minimum soft reset pulse width has
> >>>> elapsed. "
> >>>>
> >>>> But no description about what to do when clearing a Port soft reset
> >>>> to enable the port.
> >>>>
> >>>> So we need to understand clearly on why we need this change
> >>>> (e.g. what may happen without this change), and will it apply for al=
l
> >>>> existing DFL devices and future ones, or just for one specific card.
> >>>> Could you please help? : )
> >>> I touched bases with the hardware engineers. The recommendation to wa=
it
> >>> for ACK to be cleared is new with OFS and is documented in the latest
> >>> OFS specification as follows (see step #4):
> >>>
> >>>> 3.7.1 AFU Soft Resets
> >>>> Software may cause a soft reset to be issued to the AFU as follows:
> >>>> 1. Assert the PortSoftReset field of the PORT_CONTROL register
> >>>> 2. Wait for the Port to acknowledge the soft reset by monitoring the
> >>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
> >>> PortSoftResetAck=3D1
> >>>> 3. Deasserting the PortSoftReset field
> >>>> 4. Wait for the Port to acknowledge the soft reset de-assertion by
> monitoring
> >>> the
> >>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
> >>> PortSoftResetAck=3D0
> >>>> This sequence ensures that outstanding transactions are suitably flu=
shed
> and
> >>>> that the FIM minimum reset pulse width is respected. Failing to foll=
ow this
> >>>> sequence leaves the AFU in an undefined state.
> >>> The OFS specification has not been posted publicly, yet.
> >>>
> >>> Also, this is how it was explained to me:
> >>>
> >>>> In most scenario, port will be able to get out of reset soon enough
> >>>> when SW releases the port reset, especially on all the PAC products
> >>>> which have been verified before release.
> >>>>
> >>>> Polling for HW to clear the ACK is meant to handle the following sce=
narios:
> >>>>
> >>>>   * Different platform can take variable period of time to get out o=
f reset
> >>>>   * Bug in the HW that hold the port in reset
> >>> So this change is not required for the currently released PAC cards,
> >>> but it is needed for OFS based products. I don't think there is any r=
eason
> >>> to hold off on the patch, as it is still valid for current products.
> >> As you know, this driver is used for different cards, and we need to m=
ake
> >> sure new changes introduced in new version spec, don't break old produ=
cts
> >> as we are sharing the same driver. and we are not sure if in the futur=
e some
> >> new products but still uses old specs, and then things may be broken i=
f the
> >> driver which always perform new flow. Another method is that introduce=
 1
> >> bit in hardware register to tell the driver to perform the additional =
steps,
> >> then it can avoid impacts to the old products. If this can't be done, =
then
> >> we at least need to verify this change on all existing hardware and su=
ggest
> >> users to follow new spec only.
> >
> > According to the HW engineers, the RTL implementation has not changed; =
it is
> > the same as the RTL in the current PAC products. Polling for HW to clea=
r the
> > ACK is something we could have (should have?) been doing all along. The
> timing
>=20
> I also confirmed with HW engineers.  The original specification was
> not precise.  The code should have been doing this all along.

Thanks for this confirmation, then it sounds good to me. I think only Intel
hardware is using this driver now, so if this is confirmed from hardware si=
de,
then we should be safe to take this one.

Hao

>=20
> Matthew Gerlach
>=20
> > hasn't been an issue for the current PAC products, as proven by our tes=
ting.
> > However, with OFS we cannot anticipate what the timing will be for cust=
omer
> > designed products, so the specification is calling out this requirement=
 as a
> > precaution.
> >
> > I am using a development machine that has the older PAC devices install=
ed. I
> > cleared port errors on these cards as a quick check, and the reset comp=
letes
> > without hanging - which indicates that the ACK bit is in fact getting c=
leared.
> > So there is not need for any device-specific conditional statements her=
e.
> >
> > - Russ
> >
> >>
> >> Hao
> >
> >
