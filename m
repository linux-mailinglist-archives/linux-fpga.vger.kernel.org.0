Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9053738C
	for <lists+linux-fpga@lfdr.de>; Mon, 30 May 2022 04:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiE3CYf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiE3CYe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 22:24:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946EC6C57B
        for <linux-fpga@vger.kernel.org>; Sun, 29 May 2022 19:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653877471; x=1685413471;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=E9kO9th6pXLA3n+HXaU2Cvm4gTPwJxAhQAFaPKcgrsU=;
  b=RAaKTcBgnzYCXFM++6BgSnATTEFK5RnYnJYBz6J47WkPYfwqcaDeYOQ9
   bSe81K2GdE+QBgZV0l0sYEe7UppEiUE+f9CupKzn5yEDn6jyfc3bI80sf
   CzDx7/NQKmbzWdMCfbfUMGshGvIVmfEXptV4S7xxJDt5Htu+jI5g3qhfw
   6c3lcFpZWshxZ/3A7mCF/3NYJZTNXN6JXge3Tmrub5atgyyMl/37ifMSo
   HJ3x5e2K2hl88ERs0nbZic6zUOiEvgByZhxqA4VK5E73HhA+HxXLR6qFo
   4/8dkbiG39uxUnrh9QyE17tF7/HSAZilHQX5PXCeA+Nsu9Wqc6bWY0TW5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="337910779"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="337910779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 19:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="749253778"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2022 19:24:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 19:24:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 29 May 2022 19:24:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 29 May 2022 19:24:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 29 May 2022 19:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDT09rKhHH2buNtmZZuY2J/jiMV9be77qtP9qKxap26+N0xP1JcTYVnDFVfOAC0djv7iWfvVl1i6kNc3vdXSMZwzWlYJlBDPoFvYupf5ypIcrxvqYsjAryr5ACGIE49+cJ0PY/Aip/vFKRJ6BOGj3fGcsWMuaEQ1LmH8I97I8miStH7b17Uo9Us+GBZ4TYCivmDfrgCFiuQoc6pFZBQRbMWtrPkjopKxoyRwJjiQS0CBB5DgBxseQn+gkzB8yMg6h3KWnhIeFoxjTJ3Hgt8nIqA48YmP0dA3jUadE0hrup0TNrvgr5KnJUOdtJFTL+K1b40o/ie5pJ4kFSdQ71l1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa8ckl4icGkBsLurupS9MI43oYqZsexKjCnGAQBPkEo=;
 b=B8CF5GKKQu/pB5JRUSo89pfoMzXnUC4tlXlyL/GyyT61Zw+00xqr16n2xpxIdxav5W/QYXLfV4EYRyDwfHn8L8ZCtU52IQv9sjs9GGAGcQla7/BHZxoPY3kqrHwpXW897n8s74paMgA1nPfYb0k5pUuOFHyucTf6dIlxlDE34QyoXqbNrwryBl+Tz8zLcp7fJEqlBMPeJoiVHO0VfoJTw26zC8wrRI1pGWCQ8w2GIwGnc2wf8AnnvQY9A+fuE8RMrR/AY46Mn3eI7NhgkgV9beyxsFnesl1eMqtu3NsTKxOv2o1stfL+ShTt+azDk4inq5ohCLTc94VJIN4yVBDyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Mon, 30 May
 2022 02:24:23 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 02:24:23 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYU5qxOJ39GLsxhEWnWFYmGxa/460P7qCggBEMoICAFfQ5YA==
Date:   Mon, 30 May 2022 02:24:22 +0000
Message-ID: <DM6PR11MB3819D71BCE114B15AEB960B285DD9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220419030357.410495-1-tianfei.zhang@intel.com>
 <DM6PR11MB38195D7FDC316CBDEA55D91A85C29@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483247B6B612CC9A82B6C43E3CF9@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483247B6B612CC9A82B6C43E3CF9@BN9PR11MB5483.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e7964a-7399-46e5-15e9-08da41e38285
x-ms-traffictypediagnostic: SA2PR11MB5146:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB51469DE3057554461F1FEE3585DD9@SA2PR11MB5146.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDiLg//S1s9Oo/c3d4g6W46mVEXai5Y5npVRwp8UeNrF69nHJyuzjCx2rVc6hvgotMYDdkimzRdZb7wwI6HDsYHm1sZ1Bc9UfQJ5D3NlXGaCFYk/uKA6nINtzA8YEpr2UZIIa5M1k+c1NImZ5Z/KM4fscrKeTxh2AF0g13st4+jknjY1IYamrXg5WfeRRaYM1uiQAtmi9jAVecQtMWwydMErG7VISIrBJ1q63zcDJ0x9otHThP70ssiaIGTycoM6uOWhBfQi2LynBQEuZLJcQ6Jln8LFT+XOeUI5cSvkCniHEtHZUkLz2n9BW/ljroMSEuwdCiBczw1NH3X2XnlLaGmSc7i6SH+tkH8QXFUcFsTwcyfe1Nf0HRltEMRXCCtOaLu/ZciqdRh506K7whB+woUTq25d/pBKZ05dcyMQVmrP+Fn2WoqIvcYBLWdjRgF9MwXHSDN4oQxHy2sUe8U1MBK8adFT1QvXMFPrC4JJrYj3ZT4r7iQY4dEPyC6Vwc65uP+QBCoLjo/nTurLiwTiTIkgjidKJwfV8K3e/4WYxfhziSTl8052Cq/+sAR95108JvW81OfmwiP9MyvtQP1w4XgiRpopBnJpIS2V/TjC1TUeChGual1f8gA0X3IgCjSUKnUh/N7p25Kd9lsSXrX3fTV5CoC9As5MCXMXuJXQGzfrvW/1OyPBN+VBLcJySozzIHoMulBjBeygtAOdylfK5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(33656002)(6506007)(7696005)(52536014)(5660300002)(8936002)(2906002)(9686003)(26005)(38100700002)(55016003)(30864003)(83380400001)(122000001)(38070700005)(86362001)(110136005)(82960400001)(76116006)(66476007)(66946007)(66556008)(71200400001)(316002)(66446008)(64756008)(8676002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AJooEbtw84URFLXI627vNvQUFr1DWjgUz+Y08vu0QyKVwhHVHy6V1eT+Bhtk?=
 =?us-ascii?Q?+KMWB2atrNLtJ67cm4N1GKpyWCFVXsn6Ln/y2yGDbLTdBgEIuFXnjQf1mnBd?=
 =?us-ascii?Q?6VZv6meA+hOV+ShRzoMfVwqXL7e8rGRRpS6ilxtfJregedE4qUcKPCRt3Zv/?=
 =?us-ascii?Q?dWDB+iU7MAKUYoH1T4MZq6l2pKrMEG/7IsJ7StKWhkI011x6hwtdlbfj+gzl?=
 =?us-ascii?Q?yIhmRSkiFUs0KXEudApbzJ7ffNDbR3mju9E4bm9o6DT5Ypw5aRAp/i5LUdo9?=
 =?us-ascii?Q?G5N6ZfFyrPeSyTfknMyVjLslXH+3BnUKGGl50LVGMkbTxMg0ZSTg48M7O/fu?=
 =?us-ascii?Q?wUY4t+kgtUtWSn/gTik+MCm1qiKWBMrzwBRGRV0lttc+lvO32trvR9gZ+xBN?=
 =?us-ascii?Q?m36+8tt0e7nSS6q4hzAAgxEwTMRXdtdwei6emu+TdF/z6au2UNNNJ/3N8dIV?=
 =?us-ascii?Q?mS9ApokCiJDA8PnK5Y0BU5ymnbGKbFaaCp8kgwzZjEdiBhdTIHHdkaAzrwHu?=
 =?us-ascii?Q?K/Vi2o15mBcctzMrvNOjIA8vXDRN7H9r6y9+MwhqWxKx4RnktIDIQ0pz0BSn?=
 =?us-ascii?Q?Kkd438C/n0P6uBCsftGeZRB73RF6RWK7pg3C8xdWvP6CvhAUxjeumYeZhe0m?=
 =?us-ascii?Q?lb3LmpYbDZ9Tb8+Ntp/3CFYvaorqH+sSo77NDzC2k0P5ba2ZfBjUsa9nbYPw?=
 =?us-ascii?Q?EHM4KVQVUUsbPQJRtnUTHX+/Gj+GgA5kV8GxjmodPjCAAmzTPQPWCqUucA53?=
 =?us-ascii?Q?kt1xUoC/GL70kYm2pSi5O3ym8IqIAf/+ytep8/KnoQsni0GdikcEBMZ8Qih6?=
 =?us-ascii?Q?vsf2ganost1ldrL21nhtYlJVzf+LgzT3UQe1FUdZDInObC8RGRLO1TAzjlwo?=
 =?us-ascii?Q?5+9A7NF2JOgrHOcIuiQ4gBJBY0e3EZebL93AYTrz3yR/HkQjYgtyvj4rQSWR?=
 =?us-ascii?Q?YhXI4jSXAAN9HVJ0x4A+W/UQroZl7Rqnmfqf6InUPb/EKarrbt6s+RD0kv+4?=
 =?us-ascii?Q?vg7u5T48xG78eq+XmqzUJuhkGz3cJRMtLiPLPvkDTvL4K4VyDd9xXmbqGVIk?=
 =?us-ascii?Q?xdsZsBzOhI5pWdGa1cQ80k0ifUlU0/c1751cfdhvCLki7zQ1kJbxRp5gnmDD?=
 =?us-ascii?Q?MG9+S/YEe6T+FUzEtBz3GJLgX2ECfQ/w3gxuJy0Q1KPPMdm0qdm00EyZVZBO?=
 =?us-ascii?Q?rqEq/0fqDSejimF08NcwqZjQV6CK7+YF6l9gClm7+oW3gNrie7khq7Hl1OaU?=
 =?us-ascii?Q?DYsNsJ1pcPxM9bsnKWtTkf1sovLUEHbK7dLxaIvdfeDWJaEYcvgKB4DwIHKA?=
 =?us-ascii?Q?aQPdKwWEnZE84VuNqUTLUr7zrRom2JDoqW3bBWxpjfWHGarMXg9Lat5dTBBR?=
 =?us-ascii?Q?3g4A7hyGJRZqezLtWRmEsV5VqxC2oGsllj1uw8cvyCWRiaSbaKcZL8SYcM4N?=
 =?us-ascii?Q?FXxEw5XAgAsfd9nh4KJzZR/iMN1253TtRGOokI2XB98JDWY1MekUpJg8dS98?=
 =?us-ascii?Q?g39kxDMe/DmYX1E/GNKNqXSf3/kfTjv5r8/ZAeI5jnWfn7dGFTdaxBtkMiLd?=
 =?us-ascii?Q?ctGAM2cRkZcqH2jgsPTVkr7TJafTGEarHSBGO1cPGOMK8pHZcElRzkNgdp6p?=
 =?us-ascii?Q?8Dz0akOgR5WKo0PgAzxK+e+/aflC4kw0/WA1APHfbvTFNaBopAUPLyzPipXa?=
 =?us-ascii?Q?SAbKqTra0wsDOkuG36e7jj3CJ4i1ohsSSgLPq5+rUtleeCjebvk4rh64EoTg?=
 =?us-ascii?Q?d2IHSKBuJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7964a-7399-46e5-15e9-08da41e38285
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 02:24:22.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKyDvQU75OeCU4VmYO+kK4x6GN9KayBIin8pFpBa4JWKtD6si73V3n7UNETCm/WOcT/uw5GSoVljVJqaY6hY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > Subject: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision
> > > of FME/Port error
> > >
> > > From: Tianfei zhang <tianfei.zhang@intel.com>
> > >
> > > There are 2 different register layouts for FME/Port error registers.
> > > The new production like Intel PAC N6000 plans to deploy the new
> > > register format which it is more reasonable.
> > >
> >
> > Can you explain a little more why there would be different register lay=
outs?
>=20
> There is a historical problem for it, the older PAC card using the older =
register
> layout, but for now, we will use the newer register layout for OFS PAC ca=
rd.

So OFS is using the same way to distinguish different register layout?

>=20
> > There will only be two layouts or more?
>=20
> Yes, we have two layouts now.

So it could be more in the future.

>=20
> > Intel PAC N6000 "plans" to have new register format? Not finalized yet?
>=20
> N6000 and all of PAC card in the future will use the new register layout =
for
> FME/Port error register.
>=20
> > So anyone could define its own error register layout, is my understandi=
ng
> > correct?
>=20
> Yes, we suggested that they are follow our OFS spec.

So it's still possible customers have their own register definitions.

>=20
> >
> > > To distinguish the register layouts,we provide another sysfs node for
> > > revision info, but it is a bad method that using one sysfs node's
> > > value to determine the usage of other sysfs node.
> > >
> > > This patch introduces 4 reserved bits (Bit[59:56]) which are reserved
> > > by HW, dfl driver appends the FME/Port error revision info on those
> > > bits for attribution on the readout value.
> >
> > Will UUID be more reasonable than just 4bits value? If we consider this=
 is a
> > FPGA, anyone could implement its own error register layout, then just r=
eserve
> > 4bits will not be enough? I hope we don't need to modify the code and d=
esign
> > again...
>=20
> The revision was came from DFH_REVISION field in DFH register which is 4-=
bits, I
> think is enough now.
> We suggested that the customers follow our register layout design.
> In the DFH v1 spec, we will consider use the UUID but this spec has not f=
inalized
> now.

So OFS is still using DFHv0 not DFHv1?
I didn't get your point, why you think 4-bits field is enough? It's possibl=
e in the
future there could be more different register layouts, and customers could
have different register layouts, and even for OFS is still using the same w=
ay...

>=20
> >
> > >
> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > ---
> > > v2:
> > >  - add documentation for this change.
> > >  - fix the reverse xmas tree declaration.
> > > ---
> > >  .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-----=
--
> > >  drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++--=
-
> > >  2 files changed, 54 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > index d6ab34e81b9b..b886568d6071 100644
> > > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > @@ -50,46 +50,57 @@ Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > >  Description:	Read-Write. Read this file for errors detected on pcie0=
 link.
> > > -		Write this file to clear errors logged in pcie0_errors. Write
> > > -		fails with -EINVAL if input parsing fails or input error code
> > > -		doesn't match.
> > > +		The readout value has embedded 4 bits revision attribution
> > > +		in Bit[59:56] which reserved by hardware. Write this file to
> > > +		clear errors logged in pcie0_errors. Clean Bit[59:56] before
> > > +		write this file. Write fails with -EINVAL if input parsing
> > > +		fails or input error code doesn't match.
> > >
> > >  What:		/sys/bus/platform/devices/dfl-
> > fme.0/errors/pcie1_errors
> > >  Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > >  Description:	Read-Write. Read this file for errors detected on pcie1=
 link.
> > > -		Write this file to clear errors logged in pcie1_errors. Write
> > > -		fails with -EINVAL if input parsing fails or input error code
> > > -		doesn't match.
> > > +		The readout value has embedded 4 bits revision attribution
> > > +		in Bit[59:56] which reserved by hardware. Write this file to
> > > +		clear errors logged in pcie1_errors. Clean Bit[59:56] before
> > > +		write this file. Write fails with -EINVAL if input parsing fails
> > > +		or input error code doesn't match.
> > >
> > >  What:		/sys/bus/platform/devices/dfl-
> > fme.0/errors/nonfatal_errors
> > >  Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > > -Description:	Read-only. It returns non-fatal errors detected.
> > > +Description:	Read-only. It returns non-fatal errors detected. The
> readout
> > > +		value has embedded 4 bits revision attribution in Bit[59:56]
> > > +		which reserved by hardware.
> > >
> > >  What:		/sys/bus/platform/devices/dfl-
> > fme.0/errors/catfatal_errors
> > >  Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > >  Description:	Read-only. It returns catastrophic and fatal errors det=
ected.
> > > +		The readout value has embedded 4 bits revision attribution in
> > > +		Bit[59:56] which reserved by hardware.
> > >
> > >  What:		/sys/bus/platform/devices/dfl-
> > fme.0/errors/inject_errors
> > >  Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > > -Description:	Read-Write. Read this file to check errors injected.
> Write this
> > > -		file to inject errors for testing purpose. Write fails with
> > > -		-EINVAL if input parsing fails or input inject error code isn't
> > > -		supported.
> > > +Description:	Read-Write. Read this file to check errors injected. Th=
e
> readout
> > > +		value has embedded 4 bits revision attribution which reserved
> > > by
> > > +		hardware. Write this file to inject errors for testing purpose.
> > > +		Clean Bit[59:56] before write this file. Write fails with -EINVAL
> > > +		if input parsing fails or input inject error code isn't supported.
> > >
> > >  What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
> > >  Date:		August 2019
> > >  KernelVersion:  5.4
> > >  Contact:	Wu Hao <hao.wu@intel.com>
> > > -Description:	Read-Write. Read this file to get errors detected on
> FME.
> > > -		Write this file to clear errors logged in fme_errors. Write
> > > +Description:	Read-Write. Read this file to get errors detected on
> FME. The
> > > +		readout value has embedded 4 bits revision attribution which
> > > +		reserved by hardware. Write this file to clear errors logged
> > > +		in fme_errors. Clean Bit[59:56] before write this file. Write
> > >  		fials with -EINVAL if input parsing fails or input error code
> > >  		doesn't match.
> > >
> > > diff --git a/drivers/fpga/dfl-fme-error.c
> > > b/drivers/fpga/dfl-fme-error.c index 51c2892ec06d..a440bc09938d 10064=
4
> > > --- a/drivers/fpga/dfl-fme-error.c
> > > +++ b/drivers/fpga/dfl-fme-error.c
> > > @@ -39,6 +39,22 @@
> > >
> > >  #define ERROR_MASK		GENMASK_ULL(63, 0)
> > >
> > > +/* Bit[59:56] was reserved by software for error revision */ #define
> > > +ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> > > +
> > > +static u64 set_error_revision(struct device *dev, u64 value) {
> > > +	void __iomem *base;
> > > +	u64 revision;
> > > +	u64 dfh;
> > > +
> > > +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	dfh =3D readq(base);
> > > +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> > > +
> > > +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision); }
> > > +
> > >  static ssize_t pcie0_errors_show(struct device *dev,
> > >  				 struct device_attribute *attr, char *buf)  { @@
> > -52,7 +68,8 @@
> > > static ssize_t pcie0_errors_show(struct device *dev,
> > >  	value =3D readq(base + PCIE0_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t pcie0_errors_store(struct device *dev, @@ -97,7 +114,=
8
> > > @@ static ssize_t pcie1_errors_show(struct device *dev,
> > >  	value =3D readq(base + PCIE1_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t pcie1_errors_store(struct device *dev, @@ -133,11
> > > +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
> > >  				    struct device_attribute *attr, char *buf)  {
> > >  	void __iomem *base;
> > > +	u64 value;
> > >
> > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	value =3D readq(base + RAS_NONFAT_ERROR);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >  static DEVICE_ATTR_RO(nonfatal_errors);
> > >
> > > @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct devi=
ce
> > *dev,
> > >  				    struct device_attribute *attr, char *buf)
> > >  {
> > >  	void __iomem *base;
> > > +	u64 value;
> > >
> > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	value =3D readq(base + RAS_CATFAT_ERROR);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >  static DEVICE_ATTR_RO(catfatal_errors);
> > >
> > > @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device =
*dev,
> > >  	mutex_lock(&pdata->lock);
> > >  	v =3D readq(base + RAS_ERROR_INJECT);
> > >  	mutex_unlock(&pdata->lock);
> > > +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> > > +		       (unsigned long long)set_error_revision(dev, v));
> > >  }
> > >
> > >  static ssize_t inject_errors_store(struct device *dev,
> > > @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev=
,
> > >  	value =3D readq(base + FME_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t fme_errors_store(struct device *dev,
> > > --
> > > 2.26.2

