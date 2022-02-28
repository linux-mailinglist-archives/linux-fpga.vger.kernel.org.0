Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C464C6631
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Feb 2022 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiB1Jyw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 04:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiB1Jyv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 04:54:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00E13F9A
        for <linux-fpga@vger.kernel.org>; Mon, 28 Feb 2022 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646042053; x=1677578053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L2HSX05UxBAlLjVpRgze4q7Tvh056hgajNaxnYFL/Lw=;
  b=J2UXxjvzt4Om8UXhcrlBlkKPSTu9A7+p4un02UTpPAVtwdVHrvqDW7hr
   i2zymKeMlVwuEHj5JDWKpOe5HE4jLTUjgHYKecKPY974+AqKumJLZkorN
   NvqJzq6u4Pmw/ESaobs4A7dzplg36KXP9tMSzybCjbj31cAQKNEXWCV0I
   GmrpCAstEfHM54PTT2/VImm6q4eaP0IUvt2iCD6iEMzzHLnyE8yBKRsn2
   RDNpZvdwSBn3OcFxuKRH212fZryP+iXrT838F///hn6wWgpBkdXJQIijU
   ybyM8OPzteVkud9pY4X+vh//lqSRSIzFsJW8mOOdGoQd3sHExtIyT6tSN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="253038835"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="253038835"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 01:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="640835680"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 01:54:12 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 01:54:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 01:54:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 01:54:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 01:54:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8u0d4zJ1gjmdCWpWSg5UD6Iaqymtb3ACQCdU3daj+jt0XhOK6x1Z+/Z//34didxJur/lj8fgofOWUOx6oZpXYoKNqUmH05l43RyVsMhkalBew2ZggX5mGGG1BeMaWEd0ppjERJrP2oUjyow68iu/RxqMq2Q0H54kC4UKoHyzX2PwlZbpbQ5e2ZPqkhQgSpOD2lV3qWT0iakECmJvEshIYXaWgj/DfuK7PDcnh1QA3kDbe2e13Vj8q2QlCz/hOfE7LOwF4frrzhkuIkSa9dSeQsMIc9XY91YDrOadl/8FGR0T7DFdWFmBiJYdoFAvegd1SHyTddT63FEMi5PzdEpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HEsUZ7GvZkEFYsmEXFDeRoKKOvAexh+gh2IJYyJTWY=;
 b=EGGVi6J2RK37t9HfFZrmXeLy+j7Hn2GTs7h01leAb9NyFbnLHBY136/easAqcVgvmqpzemvmswVkVNzoa+cZbwlb/o31S2qemOSHmymnv5GM+4joNrM0MbCMuB6uFAnGY/NgjbupPLm3flr79DyroXqpcpDRDRUFdUKlDxTaHgIE4qiWXplueRC7XXvJehEfl0EjeHyaRWiZqXKsHHuOvC1nUO5vOru0/+QFhMNOaSMnBpm9fFQVdDs7W2IDzVzoIAv1c3KmZZqwgWiVJs5BOjT6jmwZTjD2q2RmOI+n2FR4A/mXmyhnor5OWmztqKr7PaL7sCmmYbTpbUOMdx89nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CY4PR11MB1783.namprd11.prod.outlook.com (2603:10b6:903:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 09:54:08 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:54:08 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Topic: [PATCH] fpga: altera-cvp: Increase the credit timeout
Thread-Index: AQHYKmJDLgdK8V4ybEO9fmSnuVy7lqyou8dA
Date:   Mon, 28 Feb 2022 09:54:08 +0000
Message-ID: <DM6PR11MB381994DFABA2C0F1FC4E236A85019@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220221141127.3765-1-tien.sung.ang@intel.com>
 <20220225160203.GA1377773@yilunxu-OptiPlex-7050>
In-Reply-To: <20220225160203.GA1377773@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 6a053f26-f8eb-44c4-f083-08d9faa043c7
x-ms-traffictypediagnostic: CY4PR11MB1783:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1783CF0A36CB57F91F0BA35785019@CY4PR11MB1783.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjD4g4XgvieO+eZKr3jqLUDiubwsaBjNZ/zHCVu8WRdPqfM7lYijaPS6DTISV4rQ31IYOl+t4o/LugMOb91m3Ap+vR9HK8vcm92XLGu5HKuPUVXtLsO8tsiVScx+QAy+bGRsTBF7bTpaErEUX8lLrSYq7N3Gd1kS/5/D7FspX+pT8sSl0yXqlnwebZHMi+mLMDRb3+cJgXw/S/91K0afWK8QLSv0uJfug+fKgMknnYXpTSbY2MowIJZuVO/0o1EXoFKiv8YoRiJYEE1N8uTr9nyzw6da+hpNRCvFMyGHHYfT+kUb9wuASTO6cUH9FvNjwxr6xtI0hL3eSo0cPEtx0G1bmsuuqcoq/kpSmKVZzG1BjB5tzxY6yzMhYpgBc5R/BuOjpHwXUaopYT3qswsVAXlBBLRc1USUswqcdnpn3METa0t+XDk33QI82CgZq2oeJ47fQ2FxWqQ12MRn3BNiui2BgbQ3atTHuiLIbUApOU4+zLlLJePHUo8J2Xf2SgRoZN3PHp3dzOJUe0f9d/XBthiqfr+HJY0uOuh6421tUUn+LPsmVFbVC29GmZNuKUU9Bv+IG9mqXH9ANKe2pP29ubd0GCNCBwchQI6mXdBOFNcNAPZnh5SUgiiQqKO/Migf5FfKMwaAQ33/z/OHomG+IMCItDFTewTEBmla+MSDhE/Nt1zGWxqntrTbVqqxpVLIqSTdLGaLmndNYSww/VKN7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(4326008)(66946007)(122000001)(66476007)(64756008)(6636002)(8676002)(76116006)(66446008)(110136005)(54906003)(66556008)(38070700005)(82960400001)(86362001)(2906002)(33656002)(52536014)(8936002)(5660300002)(508600001)(9686003)(7696005)(186003)(26005)(55016003)(6506007)(71200400001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AwjqxMyGg6Pb9Scs/6zUjEQslUlg/RjQd4pKZ3HFjjjuvWq7LhQ42R3fgy9V?=
 =?us-ascii?Q?sgr67y68aKrIZdXil2W07HTBYghvuaE6DB3ZGPRfMq/ebAC+qtBYeQ/u+ac0?=
 =?us-ascii?Q?A+HqHw86KJJm1y6BlC9jETVVy0up8hvOn67Mt5b9tLBED5ahQ8+yivaEdGTm?=
 =?us-ascii?Q?MeaxexL4vxcng37+O43vROjwnuflMlzcs2eFer7dX9xZPZDcoyG9rcUiw0tz?=
 =?us-ascii?Q?tsmWQAUDvP9KtobmAljVHmHmOeMC+EyJjbxX1fjd3DlDZSSl4W3ZAbgl+RyW?=
 =?us-ascii?Q?Cb+orT+7XYC0zlIkoN1s8hDxi8i2hZGy6TUE/azCRZOrVPvmfKKNN/dArtqy?=
 =?us-ascii?Q?8EpQ9EJtW7c/MGdIZ+B2vjLRyzoT+FPIX7OIdbi1C8mO4hRvZxA7P3qr3zL6?=
 =?us-ascii?Q?9T0S2PaiU38vu3DZovUrdBUFpygIGBI37g4bSk6KupnbBhWXGyLPrBcN4cln?=
 =?us-ascii?Q?0THMTqZG7Yoh1ppz8I4Fz3Pag6LV0Ul6taUhKmAX3HVI6UfA4rMNI7++EJ8T?=
 =?us-ascii?Q?VIz0OnGeTw6qMfDEq1F2TjX6n0ra8gcM5HrzAtnlXRLuqdboE0zttGR3Dg2n?=
 =?us-ascii?Q?2zEQC3M38BN/3O9g16cc2IYsehWhlnVjM9JqI/QQJADBMZ786iwXRUvoORx8?=
 =?us-ascii?Q?pmrv/b1kGtUW6rxky6e+4DotSN+5k9ue3tnOcVj4Vi9CokHcEdDmC9VYW/B3?=
 =?us-ascii?Q?d5TQN5z9QtNMJYVxYARLizPDviS2gt6BqXxCkyCbzVINJdPg1RtrbkmHXE51?=
 =?us-ascii?Q?S7spjjmekOZHJnOT6M5/tYmppJUXifQf0BqV8npeGbv6t4ibDjVfuT0Oqazg?=
 =?us-ascii?Q?LYsZo0Zojt5KN53YvGg0KzEuBJPS8Clbyr/LOX42fslO8o7WdcJRdpXzu926?=
 =?us-ascii?Q?smY+SV20CmfAhFGxGotuzWTrryBagY0+faFLIlGmEK6M5lJDvT5sLZmHsytQ?=
 =?us-ascii?Q?eEJqvQ+YpsBknFFL8vkA3PeYBGlVurweX6woh8WDAkohznXyBLzDY8SrM8DP?=
 =?us-ascii?Q?DSj/N+7U1Ci4OqBUILhLjivozQQdI7+OBLVPh5qRJ7TYPwO7KRKXpHf9FnmO?=
 =?us-ascii?Q?nyXYgphimBjXU5y9EvSq4B8Ws/x4t+hgFoqCV2wZBRVmeue4XZVGRbl8nKr3?=
 =?us-ascii?Q?q1sqBfNDec17XtHKhHp52GO09TmIdjD2NwCYake+yGdEbeoKFvOSxE6yJXBJ?=
 =?us-ascii?Q?xypfYmYUhF6HBGLboF6VKuETv4NbTfW8e8WJc1jE+WbPga1/S6K3SFiErVLi?=
 =?us-ascii?Q?L5Tjes46NpLE12/+mgA3X1s9uUC4kdhTpgAIigZ1gSeM+MwTs96Km+HBwzKG?=
 =?us-ascii?Q?ZiVOHCn5xOyqW2vjS+Mc4m43RVQe/xKFNzz4hxlBF2bPksQcLeRLAux+eS6L?=
 =?us-ascii?Q?cVeqZEM5WQqWXpZASHeoW1IO9TfaRY/VFfl35W22GWI7ebaI6T/KIyrtmLDU?=
 =?us-ascii?Q?nKloRV9zhZv79XLyzIZMcZl3B/+mDkxsHOVO/qjKQe2NvC7R9Wz/2HE0d7QQ?=
 =?us-ascii?Q?MshU6ngxARx2muuL8DQyBq2QfYAPGuoIY8WS3h8aXPve6EcKTC9IPjeEO6yt?=
 =?us-ascii?Q?LvNsbRNnwve098aQS/yyzzPkg2tQPfcvCY5raVH4CnOQVfwC1lfTqCOMEjr+?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a053f26-f8eb-44c4-f083-08d9faa043c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 09:54:08.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP7nJMjR50owhipSpjAnsi0EwEpJ1D4cVuBY2B7pqEUvBfOgT/5ZFjNKd/qWR3dAB6yhf8OAK6IQrkJ+OlFPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1783
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH] fpga: altera-cvp: Increase the credit timeout
>=20
> On Mon, Feb 21, 2022 at 10:11:27PM +0800, tien.sung.ang@intel.com wrote:
> > From: Ang Tien Sung <tien.sung.ang@intel.com>
> >
> > Increase the timeout for SDM (Secure device manager) data credits from
> > 20ms to 40ms. Internal stress tests running at 500 loops failed with th=
e
> > current timeout of 20ms. At the start of a FPGA configuration, the CVP
> > host driver reads the transmit credits from SDM. It then sends bitstrea=
m
> > FPGA data to SDM based on the total credits. Each credit allows the
> > CVP host driver to send 4kBytes of data. There are situations whereby,
> > the SDM did not respond in time during testing.

Why this timeout is changed to 40ms not 50ms or 60ms?
What's the time we expected from SDM?
I hope we don't need to change this again.

Thanks
Hao

> >
> > Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> > ---
> >  drivers/fpga/altera-cvp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 4ffb9da537d8..5295ff90482b 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -52,7 +52,7 @@
> >  /* V2 Defines */
> >  #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> >
> > -#define V2_CREDIT_TIMEOUT_US		20000
> > +#define V2_CREDIT_TIMEOUT_US		40000
> >  #define V2_CHECK_CREDIT_US		10
> >  #define V2_POLL_TIMEOUT_US		1000000
> >  #define V2_USER_TIMEOUT_US		500000
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>=20
> > --
> > 2.25.1
