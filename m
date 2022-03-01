Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E864C80FB
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 03:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiCACXj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 21:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiCACXh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 21:23:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC070043;
        Mon, 28 Feb 2022 18:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646101377; x=1677637377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RMoVEEwK02CF5vNh9GQL0N2X6byXokP95ifpU8nb7Gw=;
  b=FJyur+xVbNkJoUV75SX2BROVVcbq8X5UMFgLoxTa3d32NQhAjfzs8Dnq
   699T8tT/Ap2rnaG0W2C4m2Hc1vQYqfANolg12vc1INwjDvvBkqbbMNvIL
   1jR5BibAPo4MWYsJcFc+1Vw9+xy6Bs7G6Iy1Nh5Fitg3zL0WVKNjX7Mgl
   ZnN6Urs39KCCAkdwFID/U6fC655W+CtQ1cbKTJb+BisxbGFFeY//TNuq1
   HWw2TSehmaMUHh6Hgcz9XNT+1kfCFQw7jmb24eJSFd9isKicLGH8pUgEX
   ywKva/R7JfGD5+f6yPs950rRdj+U2XEH3JxewlV6RjNWtL3pS875GRpsS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339471571"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339471571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="641101042"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 18:22:56 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 18:22:56 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 18:22:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 18:22:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 18:22:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=falW4L389kUv7/naHv+8caC9kq7w+NYUYpK6LrUXa91GSppzWXS6LINpUzF2buR4ihC1DyQXNZX5fWjuVWwbQR0pxLz/DBPdUQlbxejPDnDE6Sq6eIiEMKS0MAaGgNvPercH/BhTMtaFIwetfInd4GciWrQOtR82MkV9/YIulHnBzuFMy6uHeBdv7HlMquuPFto+sCob3i/k9JDm4Y6ZL40FhL/FOa/otQIgR776cZ2dS/3YFPs/HWZUKg5RROVM5tXyoVk85DXmfPLJdo0XomEU1PPCcDgWVi+xI7I7R257KT9dlDP8t9ya4LtUX5M+2XUerwUwH8mlZy+jvwY2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEt0uK4KW0BLeRHlReeWq7vpvj9SUxdevs1NqKCH7SM=;
 b=SMuzMt5XkJLWOfa7TJ8ZWi+7KAoVR6jyQ9ACwifrGFA359hD0c/67ZeyNHYe7UvH5fZZs5hk9NFDCPt0IPtfFhcwWry6ltJriP0hBRNch0UioPbXlUY9LT4WfJCPLX1NeUPwxSegIBCigAZYjgLZaf+uLFR5dgpHdUxkNj6JgUwFYb5CqtqSINor5re6XUfLM8wNIZhVZoL1njcEdoxH5T3uWG0OtAHneHul8NBEvrfQHEIwUguIy85n679EItTsv58EJ/ivE9raNhiL2DS3K9iECSo/6yqb81RnBxnFiSySjOyRq9i5z6uGQJdRcrr9bHnEsS8FQwWD1KIu7ejqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 02:22:52 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 02:22:52 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYKWCM9LLv46vm40url05b1bO9gKyo0a6AgADuMYCAABDScA==
Date:   Tue, 1 Mar 2022 02:22:52 +0000
Message-ID: <DM6PR11MB3819683BD840979FF8F6084885029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220224092242.127081-1-tianfei.zhang@intel.com>
 <DM6PR11MB381942D6F18C6518FE3556B585019@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB548388C1E086059E277F4C8BE3029@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB548388C1E086059E277F4C8BE3029@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 1a6293c4-12c7-4002-01ea-08d9fb2a6351
x-ms-traffictypediagnostic: CO1PR11MB4867:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB48671EE13EB2FC3734B5C98185029@CO1PR11MB4867.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owXTeGIcEMruJi9qnSaed9JAvdf1MkPzjccbtQiiGeRsb9XmytAvckIJQpLooqAuEEDb3XsMzB9q52jZaSFwBGGtVxw9+L2SIbAJmoVu5AcdlVfSqF16BG8iUK/cbZZ4gBkUaPde+0ad9LpPIPbgFAL6A86RHRje3yNV2O7CHqHZm8Z901aMxSfEDu5w7Fb4gWbvw4lBO8hlZYiymRhfRNJIMot4cTscIR7mC+p09T0HKa2sUyCkQRvp1azbSZFePyl8TRIMsllqCkbr9pT0zA0H16BoCV7XI5dghBUmjulgji+ioxnMcUsndkTKjVjZSoWr1i6Yye4EB2iBUDNd1FFrh13l+3kvizCC8m+e7PYSkRx3h6Jrv+PUt7jwXF4VbpbgPQWsIpPg9hFxPe80U1O8I6zR8ZYqorb2FRKTCOjjdNV1QdBE++Ud0dmhMYecEAZcVB5Nxyo2rlcQeps3/dLPWAOQ6YNr1HTeKCzcCgowyGpNrXiTazvlkwqSguiGiSRIEG/OiPiwDLVjOVnWxVdN4X/zuZkEsRq6lhtIBOu2Wc2neH7Th29jrwBVrafi3ORvAOcTHb2o0AB40pJrFpa3KuUzsEteJXEPRWea2PZRUtddIkT2IHxeDLe02eu+os3N7NY09fYXJiLnfGEOepeglN+eXPYGg+jT66X/9qzRcg6cIe6N9o+5o7fiRoHq0Nbr644x90HqE9M6BISZ0GQaJPgCBerDQCPBuRhrlAqRYv7uFnHC9GL2ic439wjSPP0BZ0jRB6mI9V4+aN2QSHWrzDTNoAeVoHU3lYPhkfhy6bF3VIGXcWKRUGSdE/DZG4s9SMvH3ofWhGCNB5rfZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(52536014)(26005)(45080400002)(8936002)(82960400001)(38100700002)(186003)(110136005)(9686003)(316002)(7696005)(53546011)(2906002)(6506007)(55016003)(76116006)(86362001)(83380400001)(71200400001)(5660300002)(38070700005)(508600001)(66446008)(66476007)(66556008)(8676002)(966005)(66946007)(4326008)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IqzfQVwi71itzb2xCCEtgHgsPYJC8bdZtwmbH+Jiz1sG8kLmptDkwhuWccoG?=
 =?us-ascii?Q?21dC5cJ1klRO3MUwYPZs+4tfjJu8q2kNN0+VceiKPRkP9iBal04xfAti5vPr?=
 =?us-ascii?Q?ailuKWyOPlr8aB9ALPc1SYRw+TturX+gCViVnXZrd8g2fwlowRQrBBjmAz8+?=
 =?us-ascii?Q?tR8mA78ynHGxOConwzB6pPQDs45vQQtAkR1AHyeurYiBjgB1qubEQpqgYAMn?=
 =?us-ascii?Q?PidY7YHYcBFhwR76nDNvS9zKxiUCXBJMkG+UKLbZo9v+ryzfd1o3+ASuego3?=
 =?us-ascii?Q?sOUg/1AtKnbU9r6Yv1hL1RC0bNsNXU1xRFMs87b5f5/Cfwhkt55P9rQ/NuKZ?=
 =?us-ascii?Q?lB0RU2BO9UD3e3cSJjJ4iZ0NTSnEUOh8bUVqZXJc2AYaFXhFEw1CeJXhYkIb?=
 =?us-ascii?Q?C90CIC9/aa2yt84HUcUyltapbhF8/TS3jyDqCXicM2OU0JSqODx+BSQiXnE5?=
 =?us-ascii?Q?Vtoi48r14HZCTDFxsdavcA7QMgnEocXzt8AgSAVWiuJW4iUUqRicTECarQkk?=
 =?us-ascii?Q?4Bmqrq+cRYv9PoDy8n3XWf6Mx7gkJ8ZDlrm6UMV2EqPO2klmEuhS9/gJ3OEP?=
 =?us-ascii?Q?nUt5TzHd4Otp7VgaTdBCGa9RLrjH1n9iTwWKyfEddCIfQfGEVzQmPEtdO4qI?=
 =?us-ascii?Q?QGf1rk7xcdz8zWEtqwDclRMQLH19IlpGt4gLrT/0qrxcqVu6BXrWhIGhpsr/?=
 =?us-ascii?Q?BXqsIC8O71jdzVOLoElULhQUTTf8PaEVW84D/45sspEOTGyr9RoydeuCMKq6?=
 =?us-ascii?Q?sQfwRowHTh2L1fHKd6XgETCfQJWaqDPMj1+7K+qzuU2xSdFHK6kXqpA9YeO2?=
 =?us-ascii?Q?/iaGdAfDg1vQbESShXICOyvy4qtky9+nD8/Yr8DEBNfH4oSg6sEuEsSodvMf?=
 =?us-ascii?Q?lNeHpL8HZEBNCCQmm2dgDCM51EmQscGMP9nPILdf5NwZpVVcs6L68FoM/azZ?=
 =?us-ascii?Q?2P0HV2LPyhr6ZsoE+20Imj/tE3w4bZL9YGBHSbhfKd9l1XfvYf8hdIt9yPrm?=
 =?us-ascii?Q?P5oy7XQ528wkh6HRmfqOn8yeziMY2f661bLs1SS6etgr5NRl35o5uUR3cy4z?=
 =?us-ascii?Q?kYgxb8D6pZXG+CgpisQfXCOS3R5LTp0T4RgyHJk5/IzUJv8N4IcbjN/tH6FK?=
 =?us-ascii?Q?82BBgzFs+a6qn5g8T0gA+kMaGPuzv6SS2hREaWMcF/VoXrF3dql+oXc/FRlH?=
 =?us-ascii?Q?4AsapJYl1QDQg0FH5G9xGSoMmZq9o0crxXw+qIlo2KSPUstqte2ImUpp6cD8?=
 =?us-ascii?Q?n6vWdSqbyP0yeWLGIv9rF27Mnv6wh+Iid3mRwdiauKa7I90Gh47iLfQY/ewk?=
 =?us-ascii?Q?9tOt/B1kWrYTLoY7XUK6+x0AyJawovd1OtlrZ8g/uJb/BHIY2OFE33U49AY2?=
 =?us-ascii?Q?4aXiTJ3WNf0niYlwVyEthyIih6gkSxHfrQ/DfeBh29z88fTfqc7pQMK+ks9B?=
 =?us-ascii?Q?oUJjQmmSHrOLy85ge1n+IqrMUgDAevQaiBIOE7UQemkMSE6Nvu5arpBaaCc/?=
 =?us-ascii?Q?EXpyu+DvHxb01MvSQbaQpTEZBD1ulpsB2PUrAWMmJFW/8uggjtYtKhV4YjZQ?=
 =?us-ascii?Q?GJCJHT8wcPBS7wrrHqQaRTVUvUxrt90V+MJalbw0I1kFj1ZYCGMYGcTG1XQc?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6293c4-12c7-4002-01ea-08d9fb2a6351
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 02:22:52.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSDI9o7T1oH5fGuG3zXtQhiiuIyl5jQDFAlIUAI7YpZISFQRm/ZxnISaNw/NMCxDM+moQOoeLKA94scjLGUqxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > -----Original Message-----
> > From: Wu, Hao <hao.wu@intel.com>
> > Sent: Monday, February 28, 2022 7:10 PM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.=
org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: corbet@lwn.net
> > Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq =
info
> >
> > > Subject: [PATCH v1] fpga: dfl: check feature type before parse irq
> > > info
> > >
> > > From: Tianfei Zhang <tianfei.zhang@intel.com>
> > >
> > > The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
> > > identical, 0x12, but one is for FME, other is for Port. It should
> > > check the feature type While parsing the irq info in
> > > parse_feature_irqs().
> > >
> > > Fixes: 8d021039cbb5 ("fpga: dfl: parse interrupt info for feature
> > > devices on
> > > enumeration")
> >
> > Actually this is not a real bug, as in original design, there is no ove=
rlap for FME
> > and Port features. This is why you see features for Port doesn't start =
from 0.
> But
> > anyway I am good with such extension.
>=20
> I think this is a bug, I add some printk debug log in DFL driver, we obse=
rved that

Per original design, you should not use overlap feature IDs for FME and Por=
t as
existing products. It extends the scope/rules of using feature IDs, for you=
r
new cards, so to me, this is not a sw bug but extension.

> it was mistaken for
> the "Port User Interrput" feature device while we are parsing the FME fea=
ture
> devices, so actually it
> read out the PMCI MMIO space for "Port User Interrput".
>=20
> Here is the log:
>=20
> [90273.482859] parse_feature: DFH_TYPE_FIU
> [90273.482861] parse_feature_fiu: id:0 fme
> [90273.482864] create_feature_instance: feature id: 0xfe
> [90273.482868] parse_feature: DFH_TYPE_PRIVATE
> [90273.482870] create_feature_instance: feature id: 0x1
> [90273.482872] parse_feature: DFH_TYPE_PRIVATE
> [90273.482874] create_feature_instance: feature id: 0x7
> ...
> [90273.482895] create_feature_instance: feature id: 0x12
> [90273.482898] parse_feature_irqs, PORT_UINT_DFH: 0x3000000200001012
> [90273.482898] parse_feature_irqs, PORT_UINT_CAP: 0xbaadbeefdeadbeef
> [90273.482899] dfl-pci 0000:b1:00.0: feature: 0x12, irq_base: 2779, nr_ir=
qs:
> 3823
> [90273.482901] dfl-pci 0000:b1:00.0: Ignoring nvalid interrupt number in =
feature
> 0x12 6602 > 7
>=20
> >
> > > Link: https://lore.kernel.org/linux-
> > >
> >
> fpga/BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.nam
> > > prd11.prod.outlook.com/
> > >
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > ---
> > >  Documentation/fpga/dfl.rst |  5 +++++
> > >  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++--------------=
--
> > >  2 files changed, 27 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > > index ef9eec71f6f3..9ce418da1876 100644
> > > --- a/Documentation/fpga/dfl.rst
> > > +++ b/Documentation/fpga/dfl.rst
> > > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature
> > > driver with matched feature id.
> > >  FME Partial Reconfiguration Sub Feature driver (see
> > > drivers/fpga/dfl-fme-pr.c)  could be a reference.
> > >
> > > +Individual DFL drivers are bound DFL devices based on Feature Type
> > > +and
> > > Feature ID.
> > > +The definition of Feature Type and Feature ID can be found:
> > > +
> > > +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature=
-
> > > +ids.rst
> >
> > Thanks for tracking ID allocations. could we also add some description =
that if
> > user want to implement a new private feature, then they need to submit =
new
> ID
> > application to https://github.com/OPAE/linux-dfl-feature-id, and add so=
me
> > README file to guide people for the application process?
>=20
> That is a good point, I will add this for next version patch.
>=20
> >
> > Thanks
> > Hao
> >
> > > +
> > >  Location of DFLs on a PCI Device
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  The original method for finding a DFL on a PCI device assumed the
> > > start of the diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > index 599bb21d86af..6bff39ff21a0 100644
> > > --- a/drivers/fpga/dfl.c
> > > +++ b/drivers/fpga/dfl.c
> > > @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> > > build_feature_devs_info *binfo,  {
> > >  	void __iomem *base =3D binfo->ioaddr + ofst;
> > >  	unsigned int i, ibase, inr =3D 0;
> > > +	enum dfl_id_type type;
> > >  	int virq;
> > >  	u64 v;
> > >
> > > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > > +
> > >  	/*
> > >  	 * Ideally DFL framework should only read info from DFL header, but
> > >  	 * current version DFL only provides mmio resources information for
> > > @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> > > build_feature_devs_info *binfo,
> > >  	 * code will be added. But in order to be compatible to old version
> > >  	 * DFL, the driver may still fall back to these quirks.
> > >  	 */
> > > -	switch (fid) {
> > > -	case PORT_FEATURE_ID_UINT:
> > > -		v =3D readq(base + PORT_UINT_CAP);
> > > -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > > -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > > -		break;
> > > -	case PORT_FEATURE_ID_ERROR:
> > > -		v =3D readq(base + PORT_ERROR_CAP);
> > > -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > > -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > > -		break;
> > > -	case FME_FEATURE_ID_GLOBAL_ERR:
> > > -		v =3D readq(base + FME_ERROR_CAP);
> > > -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > > -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > > -		break;
> > > +	if (type =3D=3D PORT_ID) {
> > > +		switch (fid) {
> > > +		case PORT_FEATURE_ID_UINT:
> > > +			v =3D readq(base + PORT_UINT_CAP);
> > > +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > > +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > > +			break;
> > > +		case PORT_FEATURE_ID_ERROR:
> > > +			v =3D readq(base + PORT_ERROR_CAP);
> > > +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > > +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > > +			break;
> > > +		}
> > > +	} else if (type =3D=3D FME_ID) {
> > > +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> > > +			v =3D readq(base + FME_ERROR_CAP);
> > > +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > > +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > > +		}
> > >  	}
> > >
> > >  	if (!inr) {
> > > --
> > > 2.26.2

