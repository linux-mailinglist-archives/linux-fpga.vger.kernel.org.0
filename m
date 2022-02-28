Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372364C66C9
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Feb 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiB1KDV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 05:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiB1KCV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 05:02:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F903467D;
        Mon, 28 Feb 2022 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646042307; x=1677578307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IRcfbyFtfu1kjK+XbxquCuppMPfwL2Ey16j8sr9nnNM=;
  b=a82s7sTI++5NaCi4tNzEqO1ZdQ2RNej6gdhSVQNMtCIxOHMGPBtge2JY
   9vvtWSX+v63Q9EXHPNuq6R3nsayIQIF7KySrgJYtBRzPxhwwHstJT4XsL
   yu5Rz+wATEILJtZwa099ofmKzINyLvFdByOL+n7f+5hsARaQkega6kUge
   OPi7C414Qxd7CEd0pSIVNGCi3EqqwKZudQoaguxwmwcKQouT/SI/EDh8x
   knpsoTIC1hVJ/oOAnyw9K+6cmQug6yGlYKEUI0b2p92JiolNPihs8Ykc+
   SfH+GDwc4lGnbSL2QX3tjeBcj8UzlDquzM1NKT/3m8xWisXTSb3x5dZGL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="236353299"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="236353299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 01:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="708588542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 01:58:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 01:58:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 01:58:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 01:58:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 01:58:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrLU+Y+BB784ujQRpJut8IEKnV6huIspSM8zcU4egezQnbFYGdYKGB8ZWMUbIEJoHS1oT/5qtk0pydy+F4CDi9DgdAs2bifgU2Z4WStkk9WOWPnUNSTU5F3t+PsGJqiB/rzQZlZIBEtZ2Gb/ikwT8i0EcdA/km6d0Fe9kTvFmST2JwT17gEpc5Gp4n/DzIuuYKvgpi2BMcQHfrSAT/kKqQFBPYv+9M7FdRlRPOzAx9pnSJbYYRsDnyML8lDHT+XnKge7Bpt9Sl98h6dKr3sf5Fk1Oa46vlRinu5A6Tqd8Fdn/J/9kwBokdIcPRHK5T/LwR2F5iBL0eKKSyf0iZDsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Hgwq9+24+9Xt+B/Cywtu+laswLEZlTxWfJXF0wJbk=;
 b=cRIjiRzkobLKhV62p4cyj73Uz0InvUZDwpodEFEe7ZroCwVcI4JcVqO+jjRMR7nPWy1u+oisF9xllFeM90I/MPSdaacyZ/Bcg+7+2lEiqF1be0eO7UcY3AUzFe/GqHFlMupwpKpTFT4rFrAnDGm7ed8CH1H+Et6lErPxp2zCMbEFLRRIaGD2YjgooTrekNVHuwg42YX+mrRr+T0QhcngwtWAkbBtnwu1ETtGCWh4C06vcLlPxZs5ZOADViynQyRmxev228q6L7IDAKQWSEdMBYK0FtoULzSN1mNaUF8OwNb41Tu80I4ih9dHsx0gyQaDwavUmZanvzfhP4GOjR855g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1275.namprd11.prod.outlook.com (2603:10b6:3:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 09:58:21 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:58:21 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        Yusuf Khan <yusisamerican@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is
  not done twice
Thread-Topic: [PATCH -next] pga: dfl: pci: Make sure DMA related error check
 is  not done twice
Thread-Index: AQHYKmDvTPIYclDPJ0ydMlszHI+cxayovZbg
Date:   Mon, 28 Feb 2022 09:58:21 +0000
Message-ID: <DM6PR11MB3819C9631EAED0AFE7E8D99B85019@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220222042700.385001-1-yusisamerican@gmail.com>
 <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
 <20220225155208.GA1377611@yilunxu-OptiPlex-7050>
In-Reply-To: <20220225155208.GA1377611@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: bdf32ac2-3f0f-4db8-a475-08d9faa0da4c
x-ms-traffictypediagnostic: DM5PR11MB1275:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1275A642F66CA7496DB5BAC685019@DM5PR11MB1275.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKclNRVrlyXhfHaZ0+IPwstwZODjxC5PyIZ39MtHeJulo8jrF5aL+dbD8K6QtnWzj3ehGuykZ4ahe+5gWl4fbVJbeS0NLQjl4GvuSARRLOcDaAEOQy4NyzmLNZ7AZqnsPnwgW5Ccm0SpjChjyWK8+W0KdkeHRPQX75kkuuo6n2ACywQhlB3GGP4NEQtarrzlYTJcd4/BxsS2e+w9KMNH9d835BayeYwZx4gc9tEd/bmQAAt8OqK72eeW0KrHBvmPuhrR/yUXaE+tyBYh5cz/S9Hi1WOf7cRAHxeB1j/Yi+BnB8MO7KDvzKyHmDLMc2mD0lp29A6UVknouJ8Km4QHxSbA2uWOViMYKCjYWPsEKO0xzj5/ptg+HkGI5g9xxjtB845fBTWIPl1JHSBYsdlM6nJngjqnvcsh99+IpGhvecaJPUfnM5IFRqDwCE/mcFyUliCq1HHiDz55iQLvVvLRIH8wyCxY/6K5b4J0wx0YRUSd7HI26MPe2xmZytdCqZCuWjsf2LOB3xmlP7/FUnuKQCLOvSeZiglY5Jux7aJAbKfCdWdBq+U2AsLkIQcRSbmvC8S0wb4kkSfSSOM/cnNElf9OZQST2qw82ONeTaEtgreZgtwifES0UhIFX1Ctmt9BVaoYk8BW8Kfx/ANSE+AY6eSFbaecFQXanS2a3B4IvuhLjVw9KRzenpJm85yTiRnZw5jnEbnjka2a3fc/n1zAprG6qsWswZsJMQqctO8fZbzI45F2v3Oqi6r8QNMG+Y4eAOm/zlwelpU0Pu4BkEi6V9nRdY84gUh9eubz7eHoYxo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(966005)(508600001)(53546011)(6506007)(7696005)(54906003)(110136005)(316002)(82960400001)(122000001)(64756008)(66446008)(66476007)(9686003)(8676002)(4326008)(66556008)(8936002)(76116006)(38100700002)(33656002)(66946007)(55016003)(38070700005)(186003)(86362001)(84970400001)(52536014)(2906002)(26005)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2uxFCF7Ga0yxWElTwlCCkfGiW4Nkppj3O4vBNdOmxbajAw4E74ZkcDhEf3rQ?=
 =?us-ascii?Q?HrGVWFwYT2sKG/Q936FeFFdVhLkYtcw2m0xSCDyXseZeRYos8p3Tbr5pTxyc?=
 =?us-ascii?Q?IU4ph/NuJ50Ia1mUSi38UcF36uYLraMWMtr1kGtm+Yx4mSKdoGVjiMBAMxFR?=
 =?us-ascii?Q?N20cCrxlySWxsdhwgEukC4983F8IOmIzo71IRHVrrIibV/LsJrKZo1E9v2Er?=
 =?us-ascii?Q?J9AL16HNLyr6fCTA0IC69bBDy4UtKSUYKhVGYGNBGaTm7FUJbCHxQxqi5hG4?=
 =?us-ascii?Q?Ai8/lVCtWmsIg7A/Qg5E92/UO6+lEx58k9lOYh70+XEOtqoUg2cQ/sut0Gta?=
 =?us-ascii?Q?2TO9GtElSIrtXn73ayzaG9XNW8Q8NrRlfruEg3vSDBQ0nJn5Pd81vAtC2x+C?=
 =?us-ascii?Q?JfnrEHgfrmYZwG8Qoo5OgYeW3cpaLrE2fToKG/qu1r71E29wRVcmkzsNn/xW?=
 =?us-ascii?Q?OE0KAtjmP5IZ67aUHdqvtCPx/kDuDH8kFJ6cS4Jn1HZ+31B1xSIIadGTxP9G?=
 =?us-ascii?Q?Xsx8e38aybj7Oi9GkNd3H11dQjs8UAyjQPwtgf/Zq/00HFjVIUL5voIaoHws?=
 =?us-ascii?Q?zsET3QpuM6TLznGlsIUD2Cz/qHEuiLRzPaXadYTV3FfEh3ggVFJkpJx9M7m0?=
 =?us-ascii?Q?ALim9YlC9vGbO7hjatWnNza7dfuo/gA5wpos/7Ty4+3Uboh8ELjDeIhOA647?=
 =?us-ascii?Q?dGb8NVwqqoOJRszgeMU1mqItCf6V6YaS326YJ2ARUsttMFlaVlVghc5mX1gh?=
 =?us-ascii?Q?FyyzBYGyKWXdLyVwWbcSScp04lin/ErC5bSeDb7sGeN23y6FOoJ/PLJbZabr?=
 =?us-ascii?Q?QY8PW8RT5SuJSm4Qy7VUtpz4T4wWb8MdnRX9+BiL+moLhK1VSdsxx+kCdfEP?=
 =?us-ascii?Q?5pktfmsj7tl6Hi7VuY1LObKboTCTgzHJN7OeLNvSNahosGBZDiyVETPPiipN?=
 =?us-ascii?Q?1vT3umb40Zf8oDsvfYTvVIwWF3rY+RHaNT+0HXRvchBhKNPSHzU2y4TdZo0v?=
 =?us-ascii?Q?OTV0zj3WIl2zKuaLmy8EHQTRxiDUzcLBVXFTZ92cg0QlfhIb8s05jVenC4Kb?=
 =?us-ascii?Q?KFQtqQ1viozIkhlKBbZlIfMnmrxJdoUDMGNxkPFu5An22k5lzZE9EL9FEeXz?=
 =?us-ascii?Q?H2aC5jul0LNQizKLdLrGNpuxaB0ogEIsMjw7zFz1I6PY7QBiihyX9iGTqTsT?=
 =?us-ascii?Q?vs6A5zIIzTPiqXONfLOpI0lCjva+AbyvI0HzchbGY0RJiAPW5hlwJt5Q7NaC?=
 =?us-ascii?Q?J7UMELGYd9SZeSOpDxy+wzf0QcHndt8kc6uIHJ4VdYlO+T1yndvZHTLboBhy?=
 =?us-ascii?Q?5vDtQhI/ocyHMmMvVo3ZR+DCySy+ec27MGZX6POTewpEVdLRj09+BXRGckOS?=
 =?us-ascii?Q?Bat5Rt8qFpLBVagP+HIzDL+bRRGZ+W6OmLbTkcpwURM4CiiQBWoYDNixqD0L?=
 =?us-ascii?Q?jvutMABfRnMT4CT5W8pcsLtaCA9i+Mur3XE6y76VkStN0oy5urCiK/OSbwYE?=
 =?us-ascii?Q?2jBv8vUjgeNGMLwl1WKDLDrgJuGUS2oku3RUiUHUQhaKAnUHdu7wyIAsX2UK?=
 =?us-ascii?Q?ftCCef62QXWOGYBQveLpr5HnLWrH6ykOjHCjTy/5K/JwWQsWyXSW2mEjH9Du?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf32ac2-3f0f-4db8-a475-08d9faa0da4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 09:58:21.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMfNJ/nyCtwBoT6ZmqjVn3/9N8CQY48vnD8ARtH2cylZ8NJOPEk9zM734FJ1RxsCOj/p2eERh6x3wm7mg1bdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Mon, Feb 21, 2022 at 08:39:48PM -0800, Yusuf Khan wrote:
> > Note: This bug was introduced here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> next.git/patch/?id=3Dada3caabaf6135150077c3f729bb06e8f3b5b8f6
> > I saw this commit inside the linux-next branch, it is not present in
> > the mainline branch.
> > The linux-next branch was last updated 5 days ago, so I am unsure
> > about the state of that commit.
> >
> > On Mon, Feb 21, 2022 at 8:27 PM Yusuf Khan <yusisamerican@gmail.com>
> wrote:
> > >
> > > In the case that the DMA 64 bit bit mask error check does not fail,
> > > the error check will be done twice, this patch fixed that.
> > >
> > > NOTE: This patch is only for use in the linux-next branch as the
> > > commit that caused this bug happened there.

Thanks for the patch.
please remove this from the commit message, and fix the title
s/pga/fpga/

Thanks
Hao

> > >
> > > Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> > > ---
> > >  drivers/fpga/dfl-pci.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > index 717ac9715970..6222f18aed4b 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const
> struct pci_device_id *pcidevid)
> > >         pci_set_master(pcidev);
> > >
> > >         ret =3D dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(=
64));
> > > -       if (ret)
> > > -               ret =3D dma_set_mask_and_coherent(&pcidev->dev,
> DMA_BIT_MASK(32));
> > >         if (ret) {
> > > -               dev_err(&pcidev->dev, "No suitable DMA support availa=
ble.\n");
> > > -               goto disable_error_report_exit;
> > > +               ret =3D dma_set_mask_and_coherent(&pcidev->dev,
> DMA_BIT_MASK(32));
> > > +               if (ret) {
> > > +                       dev_err(&pcidev->dev, "No suitable DMA suppor=
t
> available.\n");
> > > +                       goto disable_error_report_exit;
> > > +               }
>=20
> Looks good to me.
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> > >         }
> > >
> > >         ret =3D cci_init_drvdata(pcidev);
> > > --
> > > 2.25.1
> > >
