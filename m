Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511C54D587C
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 03:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiCKC46 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 21:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbiCKC45 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 21:56:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7041A6FA2
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 18:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646967355; x=1678503355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2IsCt8gdjTbvZBEH68IN6Qx0SaBShBwBgqKn8srvcEE=;
  b=gAbKC5AUpQKZ7PI6NY0AsIQttYPzb4wMJIBnmP91PVPjunHraaab14/g
   QP2UOsefkG/v4WvkfUjBzAiYBG7HH+ajeztNRqc4RliwoqFFD/0Bs/kim
   wQXe/pvkHdVvceSbLNkSREtOGp70sLhhMz/ysZ6OeOt2TzNrv/SjPzFyQ
   RYd/EqX2IDGGymYGy7lLl+j8pvau0EYg1kpzGpdcvV8DA6UcGtIwWVM1F
   vynkDdPd44dGl2U1xpF/Kg4AdNeH6pu1PpCctmEgohzh5HruJ5qQ5xwJi
   bdzpavx2xzJ/xfMQM3fNktP7wIkW6kHfaXHTuqUoYfMShuX/ESzA+P11r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255433386"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255433386"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:55:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="644781795"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 18:55:54 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 18:55:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 18:55:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 18:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiqXqUBy5j/3iCqvkzHZi0WpaetzWOGChZb11FJHshaSOo67LkFWI2i8N88u3shYjukx6BviANmraXKvJvnCKdohZhJe0lGZ0j+fOPaRHKSwOHlWdj5EgNVftooqQ4ornTY6bwbehvpdX99E/ichwRXWHosJQgGyVSdNHz1UOviK6FH4QYFGzESNLy+gO2mcRKuY30ZnjFbt2OCPnzjFcNqijyJYQn42BS2Y0hNKNmgUuKd8oDrlbSEDD5TLUcc6+uzPlPe5ssW3/f90FOM3Yun89YM3Y5xi7Fx05nBt/RCSgu9F4rKirbep0kqeWDhZRbf7DYWgK/7QJDIqRAnvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXDzwmNcYjPK6R6cN4D1iLPww+8E6b4yMoqX5H5q2I0=;
 b=eT43AcnQ4kQXfPmU4eGXz2569cfJN89B06UahVMAfHCYNGcN0sEKehFFE1pzEgLeG89UOjqGSAR0aCc7B6bMgAzuydB6AZIyGfE3jp4OqOr2hE3wjIXO0eMDAtyA0y8a5l2GOj9sxUKxdOkxc472A/gWoQFa+O/Iwnq+oEzNCPCIDHOOQQOUpg1hsgGzrOSe2N4yFTCF5EIBCJUDrzSS7DAyz5quOAqJKxFXXKU6OqaZ22IoOUPCnnPbU74gkymtEJWmjrW7ihRrY5PsHq9mQpWUYQ2DwdCC2O28stpy7PF2ynHUJpgQfJi61ipzaEU/vu+Zbw6lIOZoyv5l1f0bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MWHPR11MB1952.namprd11.prod.outlook.com (2603:10b6:300:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 02:55:48 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 02:55:48 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Topic: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Index: AQHYKmJDLgdK8V4ybEO9fmSnuVy7lqyou8dAgAY3pQCACp4ecA==
Date:   Fri, 11 Mar 2022 02:55:48 +0000
Message-ID: <DM6PR11MB38191187AE2243C9D5ADC2FA850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220221141127.3765-1-tien.sung.ang@intel.com>
 <20220225160203.GA1377773@yilunxu-OptiPlex-7050>
 <DM6PR11MB381994DFABA2C0F1FC4E236A85019@DM6PR11MB3819.namprd11.prod.outlook.com>
 <DM8PR11MB5735394B66899E6244C99AA6BE059@DM8PR11MB5735.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5735394B66899E6244C99AA6BE059@DM8PR11MB5735.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d04c8bc3-30f1-4eab-9726-08da030aa57c
x-ms-traffictypediagnostic: MWHPR11MB1952:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1952721D911D0700565BBB9A850C9@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 177JrSFXdk4/U9Qj2FRwc8fg1zzJm/afH/CEJ0u9N/PaMvmsXSios511yqGpLAS9JvHqQHTniKvCxWiNP7z3I81D8zTi6sbifSCI6GydyZb3gvcwaHrHdmJKYC9jrhkescZkNscuceIiDxX9UzUE7p1APoTnJEv/sjGipcdPr8nZgViAO6a+a3zszGH5Uiu40Mv/crU7BkHhNswP308I+Rp1LaE9n+tvDAteb0YBOZccTwDeP0mr8o1j3DnF9+//icvZ/QJiEPxKywTVKt3tXdA/SOkp6R08Xwhu+XMpjC0PmXBkRH3JufDLVWcZA91ecH7T2xz1TqgLEkTMApkraEK0OG3D9MHrEO6sTMnj+s+h4zNw7WqIrGkciMO4EAkq9Fb33Am4LQAIn9EDT1c8mlMPDU6gU3mmiCEDiqBZegC4MVloZ+z92wU14P8xpsJk7KZCPZFmG9k43+zzx6LprYXmkOYVOdEXUie0g9/1XctRtFitv8AF27Y6CGE0QoXOOeAVCBF11xYY4CgEurW4Uy/LUEZ0/cbBZnHHIQDtPgm647aL0gOGCvLKvp6XbcnK2l6q80Nmtvz5mTRbvpZl7JMJePGFvVpriBKE6lrIHiJCwtiltU0jnM/gU1N3aMpnFrDYwEHdIJreuH6NqpC22E18HNvcudGIRviZSAQerqpCD8WL3CBhbYPjXb8CwYmHYARqTjL7s5X9FT8II/uomQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(76116006)(5660300002)(54906003)(33656002)(110136005)(6506007)(82960400001)(71200400001)(122000001)(2906002)(7696005)(38070700005)(53546011)(52536014)(55016003)(186003)(26005)(66446008)(64756008)(9686003)(316002)(4326008)(8936002)(66476007)(66556008)(66946007)(8676002)(38100700002)(6636002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o5ca3BHVhpNQQh3aZ/QHsogbN0wD/KsF0s18fmM/ojsIcy3MKb89lB9jslNp?=
 =?us-ascii?Q?HEH5/4vULZirqBFICWL0eSDwJsYZOfoQX4nwuZOQlEOTR07EM9zSYMtgpkrq?=
 =?us-ascii?Q?TPr2X+Q1s9lvEgIO3FMfUU5+LC8Fy6fT2Ti8ywozVWk5EGB9Ce43pN8lHbCU?=
 =?us-ascii?Q?ko4hnCT7E7kCzHP4s3yNyTKZohzlufZJjCg33eoD+BzYA9DKKXRp3Jw/HoKh?=
 =?us-ascii?Q?nwMHV8J9B95VK92bzYQ9tkRTF1fkj50WOT6QlRw6CignPqBVqWyGulDcUGrf?=
 =?us-ascii?Q?+4gH6TYIdn0jgxJuf/5pkU0HEq5D4nmmzWMvlnTNRQSWSSVBLH0sxhy05jfE?=
 =?us-ascii?Q?T5ecIX1jTRQvqKaOglhlrIftjSru71aAai5B1UetetXKnKq+e8KeHcMNAV/W?=
 =?us-ascii?Q?FqJqQM52o7keNKdXR0E5gEn/v1SSDXumbi3f0M4T9bSGO8wWzzboDhLfC9wP?=
 =?us-ascii?Q?N7GJ0Cs6aKusrRDcsiPG4/OR8r24WTEeMgjNOe7xrzOoK5h/z6RsEJoUUOiD?=
 =?us-ascii?Q?QlB0gEwZQgePwuVvkTUfMfDlRqnyOmW4ANeE3g/4OHZGayKDKaqwG05MozfX?=
 =?us-ascii?Q?FvgrMRDNuUMVW/jM63/4Ekgvj29HQbi0fqCEl9jrDgCz8KiHW2vLWg8MVbfd?=
 =?us-ascii?Q?YYzvHF1jMgofACZzE8malG8ZsWH9s8hUzYIMzmIEJss+Y/zTpDeoy/PSXluY?=
 =?us-ascii?Q?a8TCI9Oriv0BOdxnoigcuUmwx1E7lIORo7VCBzl7V4v25mzO4NnXIzWN1Cjx?=
 =?us-ascii?Q?+iYvmwVXOkFdtWDApMoj5IFm7XER2MLGpIczaadcZF5SDjLPkwe4fdIfrLTe?=
 =?us-ascii?Q?yPndkYUpPe0BDYpGzckpgHEX6Js5IGmI2FgG+VeoKI3lcxNKe8r0jplV1C/Z?=
 =?us-ascii?Q?YOSeKki8kjlT4HYQCdGhhI+Dk0jX6lIXbxWiLZ77wWg/VaFsdOsK0W3va+zk?=
 =?us-ascii?Q?7ZbZgK56z+s2wuUMY4e38KqMqWvSEhR2GqvR+H75U7OcivDpQvI0iCAtXy4b?=
 =?us-ascii?Q?bk2XqGE1AeFLrXaPx7hRKldClJCadrNmypSd6tKsKwdnPWOHvR+IiuXo1lBp?=
 =?us-ascii?Q?TcwF1zpLMlnCxLOdGaAGR0sOu0bxc5nnPCrZv2a1PLpsnrz8V2eRLCY1XVNv?=
 =?us-ascii?Q?2Wa2g9y28J2TKbtIMz1XbI0sakzj1F1ah8gagQJScxIckMw5R9CHMh70mCwD?=
 =?us-ascii?Q?Vv/D2NJiZx7yF9KSQnteIXgNSOsTOu9eM52WVZxIPN/bbJeuO1/+2yaR9EYE?=
 =?us-ascii?Q?D5oKTBvk/2lXZjNQI47qoDgb4BSTozNf04WGRRvgBibSe09yPllc10pOIZ+U?=
 =?us-ascii?Q?tNk2YXtzWzSxRx9/7FO7bssX548Q0T4lPD7d437/15mRV9T3dHdrHciioJ9Z?=
 =?us-ascii?Q?p3rthDUwuHUsmg0ROICvsuNVohXtGTBj+f7EAQpc3jzgDzEKCAW7wai5ItiX?=
 =?us-ascii?Q?5PEXG0zcTQ0C6QhiPMAWqgTFXbVmk2pdLvtu/PpQGqlVCyY4u2LGLkaAFOf2?=
 =?us-ascii?Q?N2vWUQYRZyYd5Fst4jPsPr3ACL83Tv0XFfLzi0uPpL8w4TQygeCwi2rRFSO9?=
 =?us-ascii?Q?j5tm2Hq6ZaZqhD0qklhQ6z9z3GOTBiZ7mDBfAW+Dvip0MM1DChTOLV3fMzbE?=
 =?us-ascii?Q?86B7gFyuAKZnuVAgxCS68lY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04c8bc3-30f1-4eab-9726-08da030aa57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 02:55:48.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtV7vCqpymSQ0HdiCwPWEYE8223ZjXGmOLKY7PQN5BLV7RZpOWXk1BpJe/aN3SdHP6A/Fh1GTzAtekBnIgkLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Ang, Tien Sung <tien.sung.ang@intel.com>
> Sent: Friday, March 4, 2022 4:45 PM
> To: Wu, Hao <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>; Tom Rix <trix@redhat.com>; linux-
> fpga@vger.kernel.org
> Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout
>=20
> Hi Hao,
>=20
> We have tested the 40ms change with 500 loops and deem this satisfying
> based on the recommendations by the Intel FPGA SDM HW team.
> SDM was expected to respond within  a maximum time of 20ms +-error margin=
.
> However, there were cases this weren't the case during tests.
> After many rounds of tests, they conclude that 40ms is doable.
> And, this is  double the previous time-out of 20ms.
> There is a bigger margin added this time.
> Overall, we don't intend to increase the time-out any further.

I see. Thanks.

Acked-by: Wu Hao <hao.wu@intel.com>

Hao

> Thanks
> Tien Sung
>=20
> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Monday, 28 February, 2022 5:54 PM
> To: Xu, Yilun <yilun.xu@intel.com>; Ang, Tien Sung <tien.sung.ang@intel.c=
om>
> Cc: Moritz Fischer <mdf@kernel.org>; Tom Rix <trix@redhat.com>; linux-
> fpga@vger.kernel.org
> Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout
>=20
> > Subject: Re: [PATCH] fpga: altera-cvp: Increase the credit timeout
> >
> > On Mon, Feb 21, 2022 at 10:11:27PM +0800, tien.sung.ang@intel.com wrote=
:
> > > From: Ang Tien Sung <tien.sung.ang@intel.com>
> > >
> > > Increase the timeout for SDM (Secure device manager) data credits
> > > from 20ms to 40ms. Internal stress tests running at 500 loops failed
> > > with the current timeout of 20ms. At the start of a FPGA
> > > configuration, the CVP host driver reads the transmit credits from
> > > SDM. It then sends bitstream FPGA data to SDM based on the total
> > > credits. Each credit allows the CVP host driver to send 4kBytes of
> > > data. There are situations whereby, the SDM did not respond in time d=
uring
> testing.
>=20
> Why this timeout is changed to 40ms not 50ms or 60ms?
> What's the time we expected from SDM?
> I hope we don't need to change this again.
>=20
> Thanks
> Hao
>=20
> > >
> > > Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> > > ---
> > >  drivers/fpga/altera-cvp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > > index 4ffb9da537d8..5295ff90482b 100644
> > > --- a/drivers/fpga/altera-cvp.c
> > > +++ b/drivers/fpga/altera-cvp.c
> > > @@ -52,7 +52,7 @@
> > >  /* V2 Defines */
> > >  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> > >
> > > -#define V2_CREDIT_TIMEOUT_US		20000
> > > +#define V2_CREDIT_TIMEOUT_US		40000
> > >  #define V2_CHECK_CREDIT_US		10
> > >  #define V2_POLL_TIMEOUT_US		1000000
> > >  #define V2_USER_TIMEOUT_US		500000
> >
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> >
> > > --
> > > 2.25.1
