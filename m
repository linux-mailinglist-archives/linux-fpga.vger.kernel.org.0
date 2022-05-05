Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F151B81D
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiEEGnT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 02:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbiEEGnR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 02:43:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58F47069
        for <linux-fpga@vger.kernel.org>; Wed,  4 May 2022 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651732775; x=1683268775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E3qX6gdXkXGM4sTgBubl9+r444DV3c4qdna/JK2PfIs=;
  b=U3VC2rdTaviw6J0mdapOFzjIGafh79H04B+WqAKUIIvykTbEk5Y9SVxh
   7m3YLknFWUQ8zcDt1+IMrMg1+Y5/Mu9AW5d3SkQF9fOGNp9i3roITDmWT
   f96GIClM6c/oXrOREuQ4IZHf+/VH429/h0aHI2o1hmMNVaZcoaqUfZeaS
   HYrgnDg/dWg7KwzkR4vksJ/xV+WjrukyFmDAWlfWHKgNEyoOMNfuCiVnA
   gIc0jQ5YHWmnRU0hM0Ml61lrZYkQgmlPN081fR8jmoAb5PtyU4p4aFkdj
   ZbkX9fvQJWhbgUwkIUEF+xvnJiuAjx6cc5FQmrl/asNb78jAXrH+hVInr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248553651"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="248553651"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="734760924"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 23:39:23 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:39:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 23:39:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 23:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7fY23ruoSGnjnVxk6j21Plo9tCVRylsDO5P0YszMDNesbW43IZsS3NV8OPTod/+/qLog5QU53fSyioFhPKTZvuDf5i9ldE/mZ9jXsLyuAbuMqHVycu7HNcNsaVVsmHEnQyKr5YnDYXjYgxHXcgCxlDD6mCUB/ovcPFRY3c855ENtsS2P5uAc1SqG4XZkzVrmmtd2gGKZ6ByqI5grQoj1gROprU86ilA4dsVkgyLO5N1iC0YyDx3TgD5fKJnKI7UImux2aIH1auffJvwsOyYwhHh822+VEr8mHU7ofE2Gm1c9ar6iTRtdtlP9FHRXq84yb2i1EXSKMkRL5RUHGl8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nthQ4y+lYrpdf2xKMITqxxIDqdQaPvkU2rPdgI4ME/Y=;
 b=fGDaVI2ag5WyH8Gv4/96oB9ZYEVkxrNh/hsGWuQcT7IYKOkEfA8OltpfJXqXsaEJ+aIwXVxHpnUjImgFJ8TXXanXyKJ7hDkyDSXTytphBWgtcqZghrTgh8/7ur/pemU2ckho6O216a4YJ57eOznm1wSnEzJdJQq6I7/4YiyeOq3/b8GNv9KuV4ydiwrI9VH+LHZR/jbvNy9a/JIBHnrgGAmywJvEodiJLY/g8HdtAK2+/dkEqIMfpB6CW6weFTtyRdG0lLu9/KUMU82qxYT0YZHYrvafUyXfJaFoGb1Swh7yLZUTgI8igu3Vwz0Dqff6bUMGipvppf0QEMDfC6TFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BY5PR11MB4085.namprd11.prod.outlook.com (2603:10b6:a03:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 06:39:20 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%8]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:39:20 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYWjmdUVnUjg3cmE223lhzyVv00K0IhBKAgAdcrACAAABHoA==
Date:   Thu, 5 May 2022 06:39:20 +0000
Message-ID: <BN9PR11MB5483D17A0B36B37E94DE1B9DE3C29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220427131656.588822-1-tianfei.zhang@intel.com>
 <20220430141201.GA398931@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819C70267F7AB4F474EE33885C29@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819C70267F7AB4F474EE33885C29@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 726b96aa-c8d2-43e2-ad51-08da2e61fc57
x-ms-traffictypediagnostic: BY5PR11MB4085:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB40853AF82FC6BB3BDDD0B578E3C29@BY5PR11MB4085.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ag50ynX/4re9ZOkufjae/s/fv901esanv9XTK6ejhGztJzq83AQ4OYonhRDVQ2+rcipIWD6GmQcMEFOo++/BI6bkOtDTXwYl1evywkNvQoRHDhPC9VtoAuuclyiHLcbe1ZqX0a3PAuBWbHtNmYshMfkZBsxWtl7RaKrwiaSU70BGepViViCK3uBZuJTjLIgP7hbBUx0o48TBsmf6PG5aXZZc4P06w8bRELjJH6zhE0t6Ymft8m6ibXYS45m4lYomUS5AdqLox3uyzzP4R4/FfLzuUIUvCQhvOl4md/xkL4s25aX2Cl85kRp9CAnNKtHFZFElxxFRZNSQ2975lU/d8dPUH4BMfNsmSiURqd/BtN6YW9kS2NptKNPIBfzNqF5vn7e31wyUpOq9VMhY3POvSSLi+qUUnakgbcmLY9PDLge8IyYAEelrlXlnByQa55RYV41Ue7UrELZjX9UtSNN/nMJvn4QKPhOQ4qmQ+tWx/QDjNlNkXcCutQbFsWPEl7uwS4FUaJUsENVFIuMtdYfAfZ12+ydCPnEIj67k6RyVJ9e31ldPw9vjJpgCugPXWQ3lEvrYrbyAScPNNwbMS2hOwvwaqWa5zBHXWFznOIjW8+BkT9Gu3TebrPXELUmFEaX4Py2HKJwcmUhAhAwNHMAsqSkOj4ZflyfzCD8R8bpxLXds96UsqBtcGP2xsXZ/ZYx8cuvbpJe0DoDdpqj7cSF2jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(5660300002)(54906003)(110136005)(71200400001)(8936002)(52536014)(2906002)(66446008)(64756008)(66476007)(316002)(6636002)(66946007)(4326008)(8676002)(66556008)(76116006)(7696005)(33656002)(26005)(9686003)(186003)(6506007)(53546011)(38100700002)(86362001)(38070700005)(55016003)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uxHVMfKIRpEFmTpMZs4wuDO/Bu4VuO/CEekrA0EMhrhPXLpkuzZdZ40Sky8R?=
 =?us-ascii?Q?qIgh9VhdQK6b9ogt3pRxqxYqvaNzow1tytJgHz1njYVFpjsOrN5B69sDMvEM?=
 =?us-ascii?Q?54+7R6Z7Y9e2XVjQFVgJvl/W8x50HVk16+PWw4wO+2gRt2WZeoefCXc0Kt6U?=
 =?us-ascii?Q?lqx6s3eDV5dd1UCSSu0Y2KQez1KBybxCKzKsLbqzxmLn8VsQsw4pgx/ePtbF?=
 =?us-ascii?Q?ctCi00bC42idCYzKXIyH/TLi81Qa1kMdO3ZlP4GB9kNvkL5+F+hOXtibr/Jp?=
 =?us-ascii?Q?/dEMZh2x1JHN4fhBHwcxhMKwzTovlMVQlc4A1J2c0w/f+QuaqhFTiTOZX8gQ?=
 =?us-ascii?Q?LPCS4cp/cuyDodjfmYEEZGEmtMwzzNNps4x/jbhT/NBOIcNOrlJfV89Y9LUc?=
 =?us-ascii?Q?yY0rOrrrvLMUwElU70WN/VxIoYqrpqRL8iZQ9WIz4HMxGZ87FxxuAerF3Kab?=
 =?us-ascii?Q?/SYJlnCrLJtgDU9kqR9xHOTmb7RIytqus+pdBR+vJy4MNK+BpAvfUP/dGKTc?=
 =?us-ascii?Q?GB2E7WTN3H24hH1rI5sMNugmlv0+SSg3ivG4VUe9kPFYXeyUH2FWImOzPq3V?=
 =?us-ascii?Q?okBAja0LfeqSc7/0zhGZP/ex6Bt3zyP6qIIL/1ArNw0sP0aB+eL/elO9dNw1?=
 =?us-ascii?Q?8rY6B5cdnQjY8XZ8Pl6qeBWycRhtvaouabEidDv95ERZpUd7fkIv6aRch4Ws?=
 =?us-ascii?Q?R2rUc4jhHMxuKRsxIQ/2gHcQf7gbGDuIo84JaW9PDr8LjyXDqI4x+VOdklDu?=
 =?us-ascii?Q?88VxqWsISaDV4jCOI48wPo1E2V7mqooN2rzc/ZxdaMrPxBMF2txa7ahznKbh?=
 =?us-ascii?Q?jQm9mAHXYNHAZmNbEs9EJX8WX7VqGn3X9MyRWhXrEzZWliSb3UZeMJe/7wZk?=
 =?us-ascii?Q?MKjHoCHfhCmJuTHHRZL9Nh2KBpBOmdKzTifCEI9LDxCpNC4OixpPZBaDSi39?=
 =?us-ascii?Q?2H96A6S3s8l/8Tp2i+lfTI/UDgOew7Ib5LGMJlA2fv5pwtRs4Tv0OJ1McnJ8?=
 =?us-ascii?Q?pXhvBK/k1pJaJuaAXcRGPnBr/DpcxTjpD0sAr4ml8SLaGHBb3YTVnxKXKS7E?=
 =?us-ascii?Q?M8QfH1uUYmSfM6o2DY7M5cv3dc/Hmg5BT/pZ1vTs/bKgkDGSAZvqaEHN/8Cz?=
 =?us-ascii?Q?vZ0lFdZFYYyiwtCDLTbhcsf+fQ6jYQArGLaFruMpHsOtV0Dv9Pvyy59Sv9Lh?=
 =?us-ascii?Q?1x4MtGAWzIJG97blx62wEn3LCyFWeeqFOsnZZEbpagNPcXjdtUHQ6VxbgSQa?=
 =?us-ascii?Q?94eaM/YfhebSM6sQLz3SMmkFkti9YIwQ9lgMFgbm+rNAEMgxx+rSbJo6baBv?=
 =?us-ascii?Q?l1BOhfxgoVDjA4qGKRx0kE0CbCWHAQ0T/sO81XS8DJbZ9ppBPW5wWbhStytI?=
 =?us-ascii?Q?Wz57N3n11ApGgJeObCoPc7rx/6Ia+JK+BusGerC4LXynsYPvUcXfxhD0Hc2H?=
 =?us-ascii?Q?ZI/aSD6PoJpK+35t6vIt/FRu9wCthrp4hdKXXa+xGDXERdCXYj4MRsFp4Vvz?=
 =?us-ascii?Q?L0SzQN8ysGAbvcIBlvUoBlegLN+tBIkIYtetx4tRjYU6vEd7I4HWyEwZddYg?=
 =?us-ascii?Q?klIT5yZRVNsaEjYtwy7LjmCa8tQzOX2D2eCZqUTEiQM8P6ygNidRXAdrBWCR?=
 =?us-ascii?Q?64rbANpvfc0y8NZd7sGEcSVnyeiE2PsVhZC5d9C19SbOIG8xDg1hpYAwZfNw?=
 =?us-ascii?Q?c52LLCaUTmKOOHRjOYxf6pjdO7iJht2/8QIUZWKBtcebDE41bhI9DJGUfZCm?=
 =?us-ascii?Q?8vIctKtGfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b96aa-c8d2-43e2-ad51-08da2e61fc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:39:20.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ua96pZtfSXDVsdUBKRNILd44midMlGJ8pdfhZ8LBihbUynqwmRsOVWvdXtfwBD1wzfU06tGVxDFkvWdSK0bPOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4085
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, May 5, 2022 2:38 PM
> To: Xu, Yilun <yilun.xu@intel.com>; Zhang, Tianfei <tianfei.zhang@intel.c=
om>
> Cc: trix@redhat.com; mdf@kernel.org; linux-fpga@vger.kernel.org; Matthew
> Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> > On Wed, Apr 27, 2022 at 09:16:56AM -0400, Tianfei Zhang wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >
> > > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > > not connected FME DFL. But for some cases (e.g. Intel Open FPGA
> > > Stack device), PORT DFLs are connected to FME DFL directly, so we
> > > don't need to search PORT DFLs via PORTn_OFFSET again. If BAR value
> > > of PORTn_OFFSET is 0x7
> > > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for
> > > that port. If BAR value is invalid, return -EINVAL.
> > >
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> >
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> >
>=20
> Hi Tianfei
>=20
> Please use break instead of goto (just synced with Yilun), then add
>=20
> Acked-by: Wu Hao <hao.wu@intel.com>

Thanks Hao, I will use "break" on the new one.
>=20
> Thanks
> Hao
>=20
> > > ---
> > > v4: move the location of FME_PORT_OFST_BAR_SKIP definition.
> > > v3: remove dev_dbg and use goto instead of break.
> > > v2: return -EINVAL if bar number invalid.
> > > ---
> > >  drivers/fpga/dfl-pci.c | 10 ++++++++++
> > >  drivers/fpga/dfl.h     |  1 +
> > >  2 files changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > 86ed9e4223d3..dac45f96c326 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> > >  			 */
> > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > > +				continue;
> > > +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> > > +				dev_err(&pcidev->dev, "bad BAR %d for
> > port %d\n",
> > > +					bar, i);
> > > +				ret =3D -EINVAL;
> > > +				goto unmap_exit;
> > > +			}
> > > +
> > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > >
> > > @@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev
> *pcidev,
> > >  		ret =3D -ENODEV;
> > >  	}
> > >
> > > +unmap_exit:
> > >  	/* release I/O mappings for next step enumeration */
> > >  	pcim_iounmap_regions(pcidev, BIT(0));
> > >
> > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > 53572c7aced0..06cfcd5e84bb 100644
> > > --- a/drivers/fpga/dfl.h
> > > +++ b/drivers/fpga/dfl.h
> > > @@ -89,6 +89,7 @@
> > >  #define FME_HDR_NEXT_AFU	NEXT_AFU
> > >  #define FME_HDR_CAP		0x30
> > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > > +#define FME_PORT_OFST_BAR_SKIP	7
> > >  #define FME_HDR_BITSTREAM_ID	0x60
> > >  #define FME_HDR_BITSTREAM_MD	0x68
> > >
> > > --
> > > 2.26.2
