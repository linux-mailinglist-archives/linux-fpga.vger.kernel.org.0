Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC5504A67
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiDRBV1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiDRBV0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:21:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16113E25
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650244729; x=1681780729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xt97IM1j/N09fLR6LpGwz6PLXtFC4KUAYkvXALJ3ztg=;
  b=lcXF0P8/CpeHJ/Do+5i4FPwHPMbUx2YhXMtosj8kTdy0C/lL+JRWjFGi
   Xzdov4/DrtNeZ24jKuAOLGoogjbskI3LGQSANTQh9SG25RvnHttaHSADJ
   ecZYFxG0duzFCzhL+gvab3IFFbpaflOfrNNwxZ/IrOKRdQWkMqN00ltcm
   CRkZgmKesFw/ssHl6SImh6g3zcSWF30Wgz9lrBJ2YgLVKbEAX2jJTfVWb
   yn8/6BS6Ee55r3zCVVrVOCt9oiPExvZLL7x17Jv9sZYu+3soJUKbjDwE6
   G4fDuv29sNGrRv7sw1putX3IqhRWUnxA8B+SDvqTvNrfc6YA5YH5IShLp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="250730809"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="250730809"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="613438322"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2022 18:18:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:18:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:18:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STeKjp99pqpjIOZcwapZXkXVjO61V6+dXX2ceC5skN1IucJhBM0LPL4ITo9tFwBNptCxsR6J5JHxYslnyMAddXoA60BispuiSLRBLJrWCHTwypUzk9jRmtDCEIVFqn3fLIvuRVBCXdA5CmYQSQRm9R2pGw9LumoM9+Gy46C10b3xAA0vi7BGDVlBnHP+wB2B/GJ3RPKk7FrjwcGZKK5zR8H8Vl5JV6UUXACHAIR4zP8SVPA8vHKxFVCmfrmLRkUsDI7ai1U9U95tNEfIqKckkxA5OxbW8iF5f/zqXNpsUF8f7Xy5iRItW2VhEsroBoT1G3LGxhe+VEEJViqoeSptDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+BFVmkJbcpbHSn61jMAlur13RjQ5HdzI2JqVSuG/TU=;
 b=O2hSPL1lN1pAwMBBLwd4Yflmbx4VXgzhd1q/pFGl543N+IiEkDsvt6EnZU2dkMzeHQYSj2J+WLlaKqt2dlnioVkAP9vdatX5eHe4/SFuKrrqp2xsBmkSP86CAvhRNKmWsXDYnnZUHDVqyzQN+yXin+6dfhKyr1zfGwsQAYTOgyCMI8a4MjqO3sqLi4sNDKNcsYJaWi9NMkzgavmFl6L8oWcHFQWT6WH43c/ykwlbglACj37sX+Rrcs2HdQo7lbold9LyVX+lDKEi3ouQM958o5N3T7Ubqd1x/3LxoCW6DUb4/qL4GVf3XkwbIk61BDg/oDySl6XAshRwUm0WN95tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB3432.namprd11.prod.outlook.com (2603:10b6:a03:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 01:18:45 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:18:45 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYTxeAK+xZBhNuiEywd4yPTwpOoKzyvPYAgAIoY8A=
Date:   Mon, 18 Apr 2022 01:18:45 +0000
Message-ID: <BN9PR11MB548365366CA105E3D05E1A06E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220413091519.317735-1-tianfei.zhang@intel.com>
 <20220416161814.GC301222@yilunxu-OptiPlex-7050>
In-Reply-To: <20220416161814.GC301222@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a782a89e-e2d9-4af0-d591-08da20d9621f
x-ms-traffictypediagnostic: BYAPR11MB3432:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3432FD66D04B2A6E3AA487A9E3F39@BYAPR11MB3432.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0WIURYyIh+FviT317yNTxFCMTgzKG2oJtPHfJGEzpVjTAj/G8V5orDgsfuehTHKDKMcfBYAbD5KcAJenL5qS9pxo2/n/Zwhbt6VXmCor0VAQMm2RTVmKUPFur6DlixeGS0230defic5fK7FH6p/Q0oUSQtkPminJF+i2ovYHVunxj2i68wy6NgCh6KtaYGCGre7ziVBouqqiHiNuoyBWhyJaV3khtYXyPNW96SSqpUIPDnO6CtEmXBTaPFlqhwQ4YPs0IPLv2O3x7L3IVOnTpxm1rBIRnygOSPtbFjwaZ22dbNzRMs59EhGy0FIwDd6D4R32mstM3FCdeBlSAFKfB+nUL4SGuTCQXt9Ypw4oQYgP3C1IIVHz9L+mr/lXVdhA6tptDp7m8A24BR5J1Ii9gA9Qm//r2cAS4pXJBwqCC8VeGiz1vElro4yflPf7K8z4Wky8AFAu0pdLkzF+xuqaHO+orj0u8OoIrUJ/EklWOGx93vovqWH3ukTO6D2c6+jcoKcXW7XiaAJYLuED//KI0UnAYNwRYO1Gia+6TCt25almE2Ih8R6ilHYGZW2ndH5LLA1YYrrGXdSGFISt8swU5/R9OKei3zbFR7CnLc7aTqx2/TXrD1Kn+VVP4DhVCTpgMO47Fl9sWpUHqtkudv/QpX5M1L6i+qjc/Z80thcxYJ90+6vDpUf1OF3xPpL79eK+0ZniBhyjbxq1MGZM7jNBKaMzT6hj0sVezSg+3wcCNaXcmqtL5B6lAf48h5s03yGIiW5Jzo9g1QM/ENT+X7AkDRpYs2/tklixhXHJfpLh5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(5660300002)(6636002)(33656002)(966005)(316002)(8936002)(52536014)(54906003)(7696005)(38070700005)(38100700002)(71200400001)(82960400001)(55016003)(8676002)(186003)(6862004)(4326008)(9686003)(53546011)(64756008)(83380400001)(26005)(66946007)(508600001)(6506007)(76116006)(86362001)(66476007)(66556008)(2906002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?apr5mVeDjR+1KLxjZROzEEMRRASQ/XwwJcSreEdgAswbca8+7wqVoNlBy9T/?=
 =?us-ascii?Q?BCqCHQrwiKRJfsznOGx/7wHyJVQpMvFk1P8fxgpEQW9+XOrk+Lqk8K0qIIeP?=
 =?us-ascii?Q?/cUP5UOErF32FPeDHcPdqzruo32WslJAORxNeAedASCpCNqy5682mG+QOkMM?=
 =?us-ascii?Q?7tjPX3H+XD+o81mRnV0CT01m0fmMeZ/nZHbW4Oeb7dzRDMdQGmZaMfcgLJZX?=
 =?us-ascii?Q?DGW3FPd3ah23dux0r6/amzdMqtuUsWBd0ARSyTaq8UPifWWwHundSv6h1y/h?=
 =?us-ascii?Q?ZbAmlBlUyuHflM2DqyU2Gl1pUH2mav96TeHr2DrwQEfWaPQummXUE8C/dmNa?=
 =?us-ascii?Q?Tp4gCbvnOgzMBZu2sGRX+lhipfVh4RuGwOovO9dQXx4AgAxywVNMJboWSB3I?=
 =?us-ascii?Q?MeypAUvHrNjpa8EGYYd4+d2EpGQ7H1jSvrZwGeu2Lei0b0L9A6YVKfSxn2Fq?=
 =?us-ascii?Q?dVcsf972Nm6O+eYsgdy76aG6eCtBIxlJUf1BZCbFmAfQB31Qqg7EDxCJS/nE?=
 =?us-ascii?Q?c6HUqCTLldLKHzcB0X/0JZNHGeXTx1Jf86Zav2zMiyWj8jtiqZtXgJm7PrDs?=
 =?us-ascii?Q?V2UbZRkarWeUmKru+/SH1yTA6Uf6UC5I4NRkgDPVOn5q8fz94g+8QNOGPoiz?=
 =?us-ascii?Q?0bvhw1zUboh1oDfHk9mNfbYsygXV2s4lBD5vateXbwY8XLjTIGQyV06NtH2P?=
 =?us-ascii?Q?E1KlXfFqvDDAUb2wJe7Pr+TB7hNHhZc9idmmsg/Hxo1DhIiShOfCctyKBAwd?=
 =?us-ascii?Q?eiQFhftI4niWtSDufx0bC62uqfQh61m5xdIefinU3VaEkwFmi5zElFN6VHO7?=
 =?us-ascii?Q?7jpTgDfTVZtMvIRCKm2cqe+If1AtQ/lQP4CXRm6ujLrBlJbObHjJZkYNdwaG?=
 =?us-ascii?Q?zOexdDxTntHAX7C8EfqfML7w0GtFSYedc0ie2QZ64XsJOW4TxNBUyu0/tlw5?=
 =?us-ascii?Q?kg6b6S8ZwmklWs5lhCiAo07wYda2YhyG/s+0YSvczdl5h/Ix1hwQHk3iiXru?=
 =?us-ascii?Q?wO5IpcPm49bnvif6PycZQsMrcu3Yu2HQG6HtrxrM44jsioNdG8cgoGBMQZ/g?=
 =?us-ascii?Q?hljJq9A5NUCYDxynX+EED+g0rBMx0IDm5lTOozULyzEjyXuINpfDJ8zm12f7?=
 =?us-ascii?Q?vAa+OP0XZqdGFvfHIE8nY76e91UH11SJ+MID+7ORDRtlFXOwp4C9Q8RsZhPa?=
 =?us-ascii?Q?VQOpLZnmxIPzzj4KKxyG8SWj8vMAkE+Rs7yn8+69bJArCrNZTjxIFUW00xIS?=
 =?us-ascii?Q?lJJJD3quFuM5bxo/7uST0Cyb1S18G0NG30hbtiKnm7kfW2qRNhq6lzl4gF3a?=
 =?us-ascii?Q?7hWLANKxVFvOnWhfuCxs/5dwN3Gy/vbGXa9ZtNSfGc1e3J1X2oqmyECSgIvt?=
 =?us-ascii?Q?YLoPwdyyoHQIXiGN3pPg3OUfhxZ6w4X/bDbtwm0JInDVBR4WkUvJ9vk8R3qB?=
 =?us-ascii?Q?/82edEFx7tf9iLKezuwwAxDFV8pcxa7szupR/4JhV/bpYlUG6vjbtL7qxzZ3?=
 =?us-ascii?Q?1ultG5S2aj6gl+T08+MqTiom+l2vr7VTqoNl+XoQiImM7c4BOAoTAU89pt7C?=
 =?us-ascii?Q?Cm8RAE7N1hMyKlLgatOl+5kyNVZOIeBPNcivPsibCadSP72mKuC97lZPIy+Y?=
 =?us-ascii?Q?HqSc58RVpLbAoY9dm1Od/kPpw8g8gHefMhjymUA9pMCJgaHhEtqUo0VRChBE?=
 =?us-ascii?Q?A0HIgjd773MI1Du2J+QxR0HrMMdlnY4NHsFtjUgGRsGQsYPY2552Pm401aMM?=
 =?us-ascii?Q?sr1o5B/MKA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a782a89e-e2d9-4af0-d591-08da20d9621f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:18:45.1171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4Q8NPGEkS1ffXBs7lI15O75rOnaj8uY01Tk623AWVtdHrv0HN7FSgQfTE19HsDWP1kFYQWH0TukrK5pUGPuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Sunday, April 17, 2022 12:18 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> fpga@vger.kernel.org; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> On Wed, Apr 13, 2022 at 05:15:19AM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > not connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack
> > device), PORT DFLs are connected to FME DFL directly, so we don't need
> > to search PORT DFLs via PORTn_OFFSET again. If BAR value of
> > PORTn_OFFSET is 0x7
> > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for
> > that port.
> >
> > Link:
> > https://lore.kernel.org/linux-fpga/20220316070814.1916017-2-tianfei.zh
> > ang@intel.com/
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 7 +++++++
> >  drivers/fpga/dfl.h     | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 717ac9715970..6347f31058f0 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -259,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > +			    bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
>=20
> Seems the second judgement will never be triggered?

The value is overlap, but there are different meaning, " bar >=3D PCI_STD_N=
UM_BARS" means that the bar was invalid during the PCIe spec,
"bar =3D=3D FME_PORT_OFST_BAR_SKIP" means that the HW tell us that the SW s=
hould skip searching the DFL for the port.

>=20
> Thanks
> Yilun
>=20
> > +				dev_dbg(&pcidev->dev, "skipping search DFL
> for port %d on BAR %d\n",
> > +					i, bar);
> > +				continue;
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > 53572c7aced0..e0f0abfbeb8c 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -91,6 +91,7 @@
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> > +#define FME_PORT_OFST_BAR_SKIP	7
> >
> >  /* FME Fab Capability Register Bitfield */
> >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> version ID */
> > --
> > 2.26.2
