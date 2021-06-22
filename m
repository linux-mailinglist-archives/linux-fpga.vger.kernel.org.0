Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F813AFE10
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVHlo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 03:41:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:22896 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhFVHln (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 03:41:43 -0400
IronPort-SDR: TOEUdz2aeGVNwqYHUGD5kBrwErNNpetkf42BMVE5BNUONQL3SBSlJsHFKW1YPFwuUeNSKQoEhw
 gc/1Rt/F9xlg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="207044503"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="207044503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 00:39:26 -0700
IronPort-SDR: p9zWSDH1KHSWc+jSCUTgakK/l9/L/DsmRS6l5gGPWJZJUTXvzRoizCBwlic63HizHZXZZBz+ZO
 EmFnNlpaH43g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="486809788"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2021 00:39:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 00:39:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 00:39:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 00:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0EUV8oIJGEf6OAlNhIAsYJvx6qyRv7x6Px0w12ltr+UquvU2SdWmTDlLXgtAKPPBfRkYCpKfywPFgtf4O5dBj/Y3Qm9iv14l25qJPD+ALvKUuzChQKW5u+yVtyMvrbhrGwSKUEELp7dWZPv19KYnJu00PuYOTAnCqsuqe/06SrHocm7SQHIp/zrgGnPCj+wgacbAbVXmQ9ASzh0zgC23OVt1/IGCuuHCb9WUno7VpBMZI/03uU7eoJeWfrQZp+mRidh7CdvOqjds0Hms1Y0PsgwDkqvpIFFsnymmYeabLV++Lp+0JFluCZ0GqbNLinw2u3BBGrp6S1tfgsCg7tp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caqlvAkt5mpCSo8mQsVvtFf4yR5NsMjpazcSR5yygSA=;
 b=m/3/cZvm/FeDy2332RUwOS7JVhs+l41PMelXvl+XSjsXvVwWDKCcNSsNYSgwSxiCSSbC1extRU1TK43f43fSdz0JTRqpwWTdy88aD2WSA5dTa9Vls9RrivS97g371v8OWd6HcHyMvNt8N+WBjnsj1KeXZusN+ggRl+NZw2tAYPOOGGw3uPcjG0heMTdnD0sVsTW4cBuh8/T2mgHNNLubxSBoSXa4bBnJKIryLcGlraY/HoF+GgUQqZn0FnWERWZ7MI9aE1lvkfiH5vinDJggUujf1/4P7WmQItq0xTpGL1Ij5JCPFQgaMAExTu8cwVXmEEK5MG8Mesp/nkeRnd9Y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caqlvAkt5mpCSo8mQsVvtFf4yR5NsMjpazcSR5yygSA=;
 b=oKK5pa2CL9nh/grT6K4Unp/I6gNC2Yh3VFArYk2iIlz6jXVyOfIUZXhdA4iqKbQN+zqjJKGD1ptQB/ezzI+SnXm9ipGYQ0HSgjryjGq6mOi2QWU31XsNUcllh2bLDLYwIGM8nISeiM614uqbYmR3aEMT8qiCVdfDQB0tksrVYag=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 07:39:06 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:39:06 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Thread-Topic: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Thread-Index: AQHXZydJs2OCmI4FX0OnnJ1fEYvt4qsfnJNg
Date:   Tue, 22 Jun 2021 07:39:05 +0000
Message-ID: <DM6PR11MB3819B9B2F357B9B03F7707B685099@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210622052205.GB27046@yilunxu-OptiPlex-7050>
In-Reply-To: <20210622052205.GB27046@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c9a001-1684-4fd0-da51-08d93550d075
x-ms-traffictypediagnostic: DM6PR11MB3819:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3819D77DB2658D32A10CC5B385099@DM6PR11MB3819.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbhxBXAnYC7M5PvzT+PnZ5XmJbNGFP2ZRpSGyH1YrASTQXxKu3ZtOPoABshd32XUqbtRBSwTVOWtwasNTJpXApGQFflNtGAPlqy6aEc15NDZ9c7/GoVTVdNB8JluYvjD9X/KO+i24T0B8avg33BSGFjooJJvsPLsqgU7tk0ejimLwJU78MqYmT+D4jdkUZ//0JGwwwNKBPXgPTKMunlFbJPCrH8AxfJDOQfwdeEFfTJeaIqvz0VKWB5xgdGXqIzzMovVKMV2LiBwBrrFnBe6EDuY5l8VBnHSOyv3cq13Wb1Z3DhC+So0Dp2gQIPHC49gQII7ncjIR/Lc4TXI4LxZeqnNOFroqCpHxVn3Qv8ppymknjM4rrFu31mxrHHmckyE0Ypw3cC+Xws5FE2O1zg+5JJyXCtCxj5Zy/c4Y/WM86675oDcemGQCP5KDjMfi9MWosdVESeb5j8bz0ruBCct2ilpFTda6fAW+ijCoHgWbKvwmn39xc92KsY7OyICnkLKPVHWDvSCHWygkT2iE4YoWc+IFft/155wUR5ei8/kZ5Tz/M6HOOe8sXxFebC04fKw/0pYNWUxVsuR0pAH57oupLKxFiQU1E6j9NqaxichCRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(376002)(39850400004)(346002)(8676002)(478600001)(33656002)(4326008)(6862004)(107886003)(71200400001)(83380400001)(2906002)(186003)(7696005)(8936002)(66574015)(7416002)(26005)(316002)(55016002)(9686003)(6506007)(76116006)(66946007)(5660300002)(52536014)(38100700002)(6636002)(54906003)(66476007)(66556008)(86362001)(64756008)(122000001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N6VJo0FbWX0v/H4e/NGLs88UbN6aeAs2lCxdDf+4q19YlQrmtVqwTuDJ8t?=
 =?iso-8859-1?Q?J/d3f3SMZYhKhmJ61puAloyq3/8BiaeDGqborkVxGJEe17nP1D1ew1+OgU?=
 =?iso-8859-1?Q?Ph1jvz+wTaTt0NSKlBYft3yuwUlmInrI5O8pcPC/9GuZii6O8HXxPuLzO/?=
 =?iso-8859-1?Q?06VN7fe0FRjmBcYMoYwWmtUNFiSN6FCI7wupjPIYuJRn8mnTAy5Ti3mnaw?=
 =?iso-8859-1?Q?iNzIaf5Fr9LJVlEtViGdKJZ0h5fUBW0CVFFzIxqSuSSKEk2ZQWeOaONm/q?=
 =?iso-8859-1?Q?NrlwT0U6X4DLjWmr0K/ZBmrKT65rW04fCU3RsF71y3V4Wen64G8px7+Du9?=
 =?iso-8859-1?Q?WtwH8OnSfsOVXs09EP73c+jMnIpxM31ualgHb43vIBiorlXKTUUBYLbuzj?=
 =?iso-8859-1?Q?2lNd6ceXsLXTzmBAfbYcJoZSxqHapXI37F3Re4j21dijdXYMiJKsr0OxXw?=
 =?iso-8859-1?Q?zdHN2mSpj5bXQlovOXMYGhDe/iNuKFNTOLQJWoRJIAzyB+axHJKn+KNL6j?=
 =?iso-8859-1?Q?uyNqoAw5qqFgv+2mqcih12SPXbGaa9ieMU51MxtTvSxegbA0roVZuUv8jb?=
 =?iso-8859-1?Q?V1OLDb4GtEHIFYcXFJZ036cewLEaj7rp2p80y0UZAVtFEX547Mn19b6fid?=
 =?iso-8859-1?Q?vMSRHs5ApIbPYT6aaU7sZcPbcmLsavTCuke1PkioyhumaUMC1S3qEVqo4u?=
 =?iso-8859-1?Q?7D1aRoboLHsRX/N/HmMAsq7al3QtJx8HNqykIxpEMrCzDI/mUFctNqaola?=
 =?iso-8859-1?Q?M191y8bH5ejDW81CZVUWanBbj0Jt6QMhXXd3Gudyyzr8k9vCv0tyC2gf1R?=
 =?iso-8859-1?Q?oZDXy3JryCV6ZANnUgSaW6DBTL3XWN9Vi40+cvTnRJAbbVl/dHpZgkIxpG?=
 =?iso-8859-1?Q?U49aCVaEpUFmVnwWfNXJ5IH3F4CwvPMPKlxQVhBfx6Wu6XSJUDmL3W2HMv?=
 =?iso-8859-1?Q?2Qu0Eg34r4OFsjEgZ08wMzmNuC7rqSs99WwYRQ3x/yQ4qNFWuCXF22CWaK?=
 =?iso-8859-1?Q?AD+AE+DJbX3DHwAn3h1ipaCvN5nMuYjWrsXip3YfMnCRgSuz3xZVIAWz20?=
 =?iso-8859-1?Q?ZFsz+LAjYh1svm+oB400TFw0XyQAsQARfXS9qQ9OiYHu0ABfOca2NJsoMe?=
 =?iso-8859-1?Q?JC8A3HBPejOqJ32ugqqAatYd04J6AhdAs6n9Qwm5bx/jyjilDuMrBIMEUo?=
 =?iso-8859-1?Q?DO0ZpGsVUGlMHCWcgrgnWevHR11wfiVhj8xe1jz/xhemQJPtmSXIfbdxQ0?=
 =?iso-8859-1?Q?JYRaUoaWzzaI/tCQLgqBD6shGdpg2uXIwhi4UxBeSM5aPXAHYXx7xV8aFE?=
 =?iso-8859-1?Q?b4kthzqmvQ/OAOqVRyTuURlM0lfI504ZzSY7o9bnCTHG57M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9a001-1684-4fd0-da51-08d93550d075
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 07:39:05.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5+tvaQ6N10rGJfQJEPwM4WEGTSz25ynN6fVK7gUzDiwz8b+S3+jyc4z4Gpcm2ujHeynercnLut4I75ZyUowig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3819
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Mon, Jun 21, 2021 at 06:19:15PM +0800, Wu, Hao wrote:
> > > Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
> linux/dfl.h
> > >
> > > From: Debarati Biswas <debaratix.biswas@intel.com>
> > >
> > > Device Feature List (DFL) drivers may be defined in subdirectories ot=
her
> > > than drivers/fpga, and each DFL driver should have access to the Devi=
ce
> > > Feature Header (DFH) register, which contains revision and type
> > > information. This change moves the macros specific to the DFH registe=
r
> > > from drivers/fpga/dfl.h to include/linux/dfl.h.
> >
> > Looks like it requires to access the revision info in the next patch, b=
ecause
> > current dfl_device doesn't expose related information.
> >
> > @Yilun, do you have any concern to expose those info via dfl_device?
>=20
> Exposing these header register definitions are good to me. These register=
s
> are in DFL device's MMIO region, so it is good to share these info with
> all DFL drivers.

I mean expose revision via dfl_device, as dfl core already reads the DFL
header, it sounds duplicate read in each dfl device driver. And if we
consider this as a common need from dfl device driver, then the code
can be moved to a common place as well.

I hope from dfl device driver side, it doesn't need to know details of
how DFH register is defined, only simple way from dfl device data
structure or some simple helper function, then dfl device driver could
know all common information from DFH.

How do you think?

Thanks
Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > Thanks
> > Hao
> >
> > >
> > > Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Martin Hundeb=F8ll <mhu@silicom.dk>
> > > ---
> > >  drivers/fpga/dfl.h  | 48 +----------------------------------------
> > >  include/linux/dfl.h | 52
> +++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 53 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > > index 2b82c96ba56c..6ed0353e9a99 100644
> > > --- a/drivers/fpga/dfl.h
> > > +++ b/drivers/fpga/dfl.h
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/bitfield.h>
> > >  #include <linux/cdev.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/dfl.h>
> > >  #include <linux/eventfd.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/interrupt.h>
> > > @@ -53,32 +54,6 @@
> > >  #define PORT_FEATURE_ID_UINT         0x12
> > >  #define PORT_FEATURE_ID_STP          0x13
> > >
> > > -/*
> > > - * Device Feature Header Register Set
> > > - *
> > > - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header
> registers.
> > > - * For AFUs, they have DFH + GUID as common header registers.
> > > - * For private features, they only have DFH register as common heade=
r.
> > > - */
> > > -#define DFH                  0x0
> > > -#define GUID_L                       0x8
> > > -#define GUID_H                       0x10
> > > -#define NEXT_AFU             0x18
> > > -
> > > -#define DFH_SIZE             0x8
> > > -
> > > -/* Device Feature Header Register Bitfield */
> > > -#define DFH_ID                       GENMASK_ULL(11, 0)      /* Feat=
ure ID
> > > */
> > > -#define DFH_ID_FIU_FME               0
> > > -#define DFH_ID_FIU_PORT              1
> > > -#define DFH_REVISION         GENMASK_ULL(15, 12)     /* Feature revi=
sion */
> > > -#define DFH_NEXT_HDR_OFST    GENMASK_ULL(39, 16)     /* Offset to ne=
xt
> DFH
> > > */
> > > -#define DFH_EOL                      BIT_ULL(40)             /* End =
of list
> > > */
> > > -#define DFH_TYPE             GENMASK_ULL(63, 60)     /* Feature type=
 */
> > > -#define DFH_TYPE_AFU         1
> > > -#define DFH_TYPE_PRIVATE     3
> > > -#define DFH_TYPE_FIU         4
> > > -
> > >  /* Next AFU Register Bitfield */
> > >  #define NEXT_AFU_NEXT_DFH_OFST       GENMASK_ULL(23, 0)      /* Offs=
et
> to
> > > next AFU */
> > >
> > > @@ -403,27 +378,6 @@ struct device *dfl_fpga_pdata_to_parent(struct
> > > dfl_feature_platform_data *pdata)
> > >       return pdata->dev->dev.parent->parent;
> > >  }
> > >
> > > -static inline bool dfl_feature_is_fme(void __iomem *base)
> > > -{
> > > -     u64 v =3D readq(base + DFH);
> > > -
> > > -     return (FIELD_GET(DFH_TYPE, v) =3D=3D DFH_TYPE_FIU) &&
> > > -             (FIELD_GET(DFH_ID, v) =3D=3D DFH_ID_FIU_FME);
> > > -}
> > > -
> > > -static inline bool dfl_feature_is_port(void __iomem *base)
> > > -{
> > > -     u64 v =3D readq(base + DFH);
> > > -
> > > -     return (FIELD_GET(DFH_TYPE, v) =3D=3D DFH_TYPE_FIU) &&
> > > -             (FIELD_GET(DFH_ID, v) =3D=3D DFH_ID_FIU_PORT);
> > > -}
> > > -
> > > -static inline u8 dfl_feature_revision(void __iomem *base)
> > > -{
> > > -     return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > > -}
> > > -
> > >  /**
> > >   * struct dfl_fpga_enum_info - DFL FPGA enumeration information
> > >   *
> > > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > > index 6cc10982351a..1cd86b2e7cb1 100644
> > > --- a/include/linux/dfl.h
> > > +++ b/include/linux/dfl.h
> > > @@ -8,7 +8,9 @@
> > >  #ifndef __LINUX_DFL_H
> > >  #define __LINUX_DFL_H
> > >
> > > +#include <linux/bitfield.h>
> > >  #include <linux/device.h>
> > > +#include <linux/io.h>
> > >  #include <linux/mod_devicetable.h>
>=20
> The <linux/io-64-nonatomic-lo-hi.h> is needed here, or readq/writeq
> definitions may be missing on some platform, as the kernel test robot
> says.
>=20
> Thanks,
> Yilun
>=20
> > >
> > >  /**
> > > @@ -83,4 +85,54 @@ void dfl_driver_unregister(struct dfl_driver *dfl_=
drv);
> > >       module_driver(__dfl_driver, dfl_driver_register, \
> > >                     dfl_driver_unregister)
> > >
> > > +/*
> > > + * Device Feature Header Register Set
> > > + *
> > > + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header
> registers.
> > > + * For AFUs, they have DFH + GUID as common header registers.
> > > + * For private features, they only have DFH register as common heade=
r.
> > > + */
> > > +#define DFH                     0x0
> > > +#define GUID_L                  0x8
> > > +#define GUID_H                  0x10
> > > +#define NEXT_AFU                0x18
> > > +
> > > +#define DFH_SIZE                0x8
> > > +
> > > +/* Device Feature Header Register Bitfield */
> > > +#define DFH_ID                  GENMASK_ULL(11, 0)      /* Feature I=
D */
> > > +#define DFH_ID_FIU_FME          0
> > > +#define DFH_ID_FIU_PORT         1
> > > +#define DFH_REVISION            GENMASK_ULL(15, 12)
> > > +#define DFH_NEXT_HDR_OFST       GENMASK_ULL(39, 16)     /* Offset to
> next
> > > DFH */
> > > +#define DFH_EOL                 BIT_ULL(40)             /* End of li=
st */
> > > +#define DFH_TYPE                GENMASK_ULL(63, 60)     /* Feature t=
ype */
> > > +#define DFH_TYPE_AFU            1
> > > +#define DFH_TYPE_PRIVATE        3
> > > +#define DFH_TYPE_FIU            4
> > > +
> > > +/* Function to read from DFH and check if the Feature type is FME */
> > > +static inline bool dfl_feature_is_fme(void __iomem *base)
> > > +{
> > > +     u64 v =3D readq(base + DFH);
> > > +
> > > +     return (FIELD_GET(DFH_TYPE, v) =3D=3D DFH_TYPE_FIU) &&
> > > +             (FIELD_GET(DFH_ID, v) =3D=3D DFH_ID_FIU_FME);
> > > +}
> > > +
> > > +/* Function to read from DFH and check if the Feature type is port*/
> > > +static inline bool dfl_feature_is_port(void __iomem *base)
> > > +{
> > > +     u64 v =3D readq(base + DFH);
> > > +
> > > +     return (FIELD_GET(DFH_TYPE, v) =3D=3D DFH_TYPE_FIU) &&
> > > +              (FIELD_GET(DFH_ID, v) =3D=3D DFH_ID_FIU_PORT);
> > > +}
> > > +
> > > +/* Function to read feature revision from DFH */
> > > +static inline u8 dfl_feature_revision(void __iomem *base)
> > > +{
> > > +     return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > > +}
> > > +
> > >  #endif /* __LINUX_DFL_H */
> > > --
> > > 2.31.0
> >
