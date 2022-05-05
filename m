Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053E51B81B
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiEEGmN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiEEGmM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 02:42:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B71A3A7
        for <linux-fpga@vger.kernel.org>; Wed,  4 May 2022 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651732714; x=1683268714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RxcdbEUIpOu81f7s50uy6r33KPMH86/ylRe14TkaBSg=;
  b=Hxu8yHnLHQ8fcdTtuuIVCI/G2QdoYDo8RhCwVZoJLglGsMUwTFszZ/Un
   8Ng8qZEK2HztK7YRfENpFfc/WU1Hzwn5SSxadOulrzI64LsDwRyzsCXcH
   8/tAYA3LTqlTeDNC52XZ8aFmH6c1YGfUftZThyrEmA7+f3b3/c708+umy
   V+TOeobodEjkkTLZyZgVr6big2iQMWPpamKPUxNPfH5JAbXig4mPWke63
   GQ5VKqxCPkWhXct0bmSAPNi32aq6i4LOzvqyWtIwduaS2BLQnEq0pEmSi
   VfSGj9OaKsy56zhS5tPl0hvUboiQnKV3Lo1StlVfmGGdeomLwA/OAb0tE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="328558008"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="328558008"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="664835929"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2022 23:37:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:37:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 23:37:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 23:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT1qTRx/4tDvl+gGO4G9UzPYUmpUgi5sYnV4aQNm07TGVs0PsRLMxwRN8LaHOUkiIFpXasuXtlAYE4F1idYLwNNfmHBNPFDaP+OicfrupDNZNG00blcEPcLSPCS+6t6lj2Gju3ROZS0cAya8grphqu14bUoImr4UrSI+OfxB59jzhDPLM9FrY4qvdiU1FqAaiRHjc/ZDLU95L9ZOoM/WYiDigPrQQh7Gd5GxoPvC1/TDg2zD1Y7YZhDwJFa3mq5QVSbjGxTCYkKnDQ7MfUN9Ff/wDK6HmWHZ1BccZunE1jbamCzoymQU3Qg28u75CWjko7EEKAqjJFyfj925s8BFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV0SKb3BTwTgZivAgiQoaUqmrZ/h4U50Ji01ZF3iT84=;
 b=hoxLdUfmrXQ9vxifRC80RBi4TlyMDPFB8SnOTigwJUaeIzlcFa6bYSd619i+iJrdfB86QyfSZeo9mRr54fw5URJDdi0fs0xa/wRl3Sh7+o2CyCAO/ymmlSMxEwCISsnasYRK9qiMCWrFfCpuZzbD1TFjVArtA/kuItNNxSvm0W2YUtabROrKQEY8citWDB/R0s/MLt4ShGl+uGmx4QLFOtqUMO6ufw4o05feOm/aUWH7WHW5c3nH8JxtVR2h1L9GO3Kmz+VtJ+i3hh6tcQ+ppXYIAbMG5CUm1ZSNJ0Ot0A3dJ+Hgurq2lLuNpHtxQGLRHMTTVjDzi2vm0CDpJD5PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN6PR11MB1746.namprd11.prod.outlook.com (2603:10b6:404:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 06:37:32 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:37:32 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYXJ1fi1LFTxrhKkGtmL7ceBgnEq0P21GQ
Date:   Thu, 5 May 2022 06:37:32 +0000
Message-ID: <DM6PR11MB3819C70267F7AB4F474EE33885C29@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220427131656.588822-1-tianfei.zhang@intel.com>
 <20220430141201.GA398931@yilunxu-OptiPlex-7050>
In-Reply-To: <20220430141201.GA398931@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dda9935-da9f-4cd3-3219-08da2e61bbb8
x-ms-traffictypediagnostic: BN6PR11MB1746:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1746E7E5EE3437680FC584DC85C29@BN6PR11MB1746.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXUzA2SkC28KEjKePvrU5Dk/a+WxbLZo5XwY76I45pQIWJN6gA01sinTEJiQNlZrmi1QJAATI/wTSvMtJm83IZjwG1swZ/7vU8hpoq/9D3Dm55a7lSv10/DHNHw0Bg6x+Lze1S/K4ao5X1XaAcYgWnF2NzX8TDKAN/rQRr0IG3n/mo2VxkeWAyYzlO+67pm/u/8A5xJkZSDs4rIAkwHdkrRPEKBmYXKO2ZG9f1fuZPMymuTaceUt9unZbmQ6egu0jwJtBUNVO8BYbqCFmG38EV6KPEGjAj3ZT/2gFHxOrbN6euDDELSavFzhLV8cMpuUf9Mh8TOu1i3NNnDzKeYEDihMVUQbighVW8FjGboFuKjkAzdVed1g5QcrZd/EWR9rNvWOpToyy5hEH/Yt7Ifc0+m3Udf4an19Mjv97JKbdAao+q9hwCJqO7oMgteAJTybruFzM0RqtWWLimdZxSmfZ915JxcZR60J0jbOfdCPclYWEbltJPcnaHAtCfsfcwW00bnBRLAcbjr7C+u5D5mHEp2XYGg1RBLP7tvlxtxo3EHrTg4T1pL1vCEZcQrUGcDVSb3yAlaOHHg8Am2nG9kf1p8WoIjq6VP4+yXIw8eMWv+8uKSc3419nGIDh1L01szixhVx2IFk+cyAGI1bqeFl8vwD2MhZ4/XPHP98GIxXC6Ab/rrP19NBc4Of9WmCgSvgcAoqbEhpfD/SRT9x7iQJQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(26005)(38070700005)(7696005)(38100700002)(122000001)(86362001)(9686003)(82960400001)(186003)(33656002)(66446008)(66476007)(316002)(64756008)(5660300002)(4326008)(8676002)(66556008)(66946007)(76116006)(52536014)(55016003)(2906002)(54906003)(8936002)(6636002)(110136005)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0j4izO2dikoucrC20lUFtdPPfxdBEk9o9XcNBDY2xd3N74nwiVkFFtFjCMg?=
 =?us-ascii?Q?GsOnvyTEiaK6hW6Gwp55r7GoMJfIlacUkbu70+kKaSjj7LyWEpdRKjtTeoLP?=
 =?us-ascii?Q?vw1oaPJKi+rjIqvzAB20yD91Yicr+bvQytWJjJyspTDvZoSkMU/vS2o5yyB3?=
 =?us-ascii?Q?QH/a9A0j5OQYOv98dOtwBA0ukFNbq0nDFZ9XGYrSfKx61A6IoOdFBXPK6ORI?=
 =?us-ascii?Q?95lCtXMlEW0cmfaQa4EYXimMwF5Ncp9+AByGBPsh56xsZ7L9iBX+cMDPBv59?=
 =?us-ascii?Q?pzPjs/tPfN2x2LWW9FbtwgDbUM+pTuqp6YDRxMEUzvuue8Zvia4QPHFvz3s8?=
 =?us-ascii?Q?8hr0nOfvY83JXv/O/zx7RYCjjtAjbZjf0xxv937VqN+TXOtE1+ZO3tInlv/9?=
 =?us-ascii?Q?fD0zsbOAeNvJ5LmKLMRtMz3vqQpEE+YnKImRsvJgPS3d8Y2EzL5iZMszZfZY?=
 =?us-ascii?Q?edxN2K10nbKNj7ut+Qm8OFfLZS4t3BgoHN2kmBVPRgmbJm+85ejOwPjaic6K?=
 =?us-ascii?Q?SdEh5UHCqeu/RglKO04tx4fr9TRmnGG0RtvDVAksjITSVeHrzV5asapGcSOh?=
 =?us-ascii?Q?36s96mTvLFxezpssorWfInOm/KGZKJAkavWpjXKKMeJ8Q5J+BC+3Sorc/xXA?=
 =?us-ascii?Q?EoAqGnkcM8EI0sU7pm42bQxwNY1BN1xtHeg42dK9407edx/210y4lL2wNhDs?=
 =?us-ascii?Q?ZLR3bDpC5C4ScWe+R27n5J2abZo9TbABj+WTtSZ/kKemS5WVm7Oukewm1aAB?=
 =?us-ascii?Q?+oLLPyZXiKR1/1Ir/I8ikwmrY/oc2hmW/qgnPcOUrHU2kZBYnySJRuPtnmNq?=
 =?us-ascii?Q?T+l7bU71cfB4F29Wx5mH/r+Drw7fqs/y2UFb52GeeY3gWtqys7ccxUyBVPsg?=
 =?us-ascii?Q?HI4gdAdgDZ+poq0xNpDp0M70vkjVXMxkD8qJkvF4PX1oTgmXfV4m1X4rSPFC?=
 =?us-ascii?Q?mCytkylfhesE6sdE7d/GImHFc0bAIo87pBE6F8nMhSn8G44LeX+sUkGVwr+n?=
 =?us-ascii?Q?eKgkrpMqG5bTgIa5TPFCyIQEt7117EKT5LZYM2eTM/A1vWmuefzMcMVLoYN8?=
 =?us-ascii?Q?i8ApgZe9AQx1y53OX/5aUYw5LhVZBuwjCwBrnFlCEtqzqWM4FcBF8tqwKuw+?=
 =?us-ascii?Q?X9Lf9hQByFH5fAbXDYcPOXyzjdstDq9JINtEjSUjiNfNrf4nP4DQfG1L6xE1?=
 =?us-ascii?Q?tUYvFK0/Esbm2Vr23bnTUryQa2BdYbaSTHhqzgXXCHtzw89TmM7ew0ch+urL?=
 =?us-ascii?Q?wdN46dwAbRL2Syjik8n7tMANzFtmk2qrN4w1imRfga8aa6qM2kOx3gvbzv9U?=
 =?us-ascii?Q?z+6ppKvVGgNbxZvFN2DXuIbvkNKSEttd6MShm1GSiG4tFuaV7FbkTlqg7xUg?=
 =?us-ascii?Q?CgKY86iEsi+pFo4LlLohkZ9KBESen4oNyhMSgGdsOpTg2ISUk3EwFSNPkmKw?=
 =?us-ascii?Q?ULXFqrPKOIWduJan3UwdtYvKY3SgWrHNEQoJdUz+Y0ke5FoHRH5PRWINCl8R?=
 =?us-ascii?Q?B1QYVI0j9eHsoJLkNsDmrHN646fGQtV5fKJgBq4Hg67MaqkBodiUz8t64lbZ?=
 =?us-ascii?Q?7SiJUdXRfNIUkw+xEMiqsZiIxcY59p5XNwzSP5x4QmjK3hP1T3MWMbjZIFw+?=
 =?us-ascii?Q?CPEsJykbqqkKagikXVsYqW88wGX0qiw0bZzlHWdGA64aAClXWdGcgX7HVNeJ?=
 =?us-ascii?Q?B8YFFKaxDsAHvmcEhY0RVMswhBxHize81XblXy241TyBTHqVNBZnTKfIAvhd?=
 =?us-ascii?Q?22JxmC5EuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dda9935-da9f-4cd3-3219-08da2e61bbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:37:32.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/HKGcCSLA0k3aauEv3pOj2pTeqQ4+Bl7Y9fbqC9iH9E6Z0p7Nbx6BY3eyZcMzOtUAeF3G+o89NEIiU2pS5vTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1746
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Wed, Apr 27, 2022 at 09:16:56AM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are no=
t
> > connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack devic=
e),
> > PORT DFLs are connected to FME DFL directly, so we don't need to search
> > PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for th=
at
> > port. If BAR value is invalid, return -EINVAL.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20

Hi Tianfei

Please use break instead of goto (just synced with Yilun), then add

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

> > ---
> > v4: move the location of FME_PORT_OFST_BAR_SKIP definition.
> > v3: remove dev_dbg and use goto instead of break.
> > v2: return -EINVAL if bar number invalid.
> > ---
> >  drivers/fpga/dfl-pci.c | 10 ++++++++++
> >  drivers/fpga/dfl.h     |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 86ed9e4223d3..dac45f96c326 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > +				continue;
> > +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> > +				dev_err(&pcidev->dev, "bad BAR %d for
> port %d\n",
> > +					bar, i);
> > +				ret =3D -EINVAL;
> > +				goto unmap_exit;
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > @@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev *pci=
dev,
> >  		ret =3D -ENODEV;
> >  	}
> >
> > +unmap_exit:
> >  	/* release I/O mappings for next step enumeration */
> >  	pcim_iounmap_regions(pcidev, BIT(0));
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 53572c7aced0..06cfcd5e84bb 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -89,6 +89,7 @@
> >  #define FME_HDR_NEXT_AFU	NEXT_AFU
> >  #define FME_HDR_CAP		0x30
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > +#define FME_PORT_OFST_BAR_SKIP	7
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> >
> > --
> > 2.26.2
