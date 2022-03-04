Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB93B4CCAB1
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Mar 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiCDAVg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Mar 2022 19:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiCDAVe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 3 Mar 2022 19:21:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71165AD122;
        Thu,  3 Mar 2022 16:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646353247; x=1677889247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T9WPo0qnXZotHfyvgI4EW6E9ew9GFI0NPxyeDdbRJN4=;
  b=OmeRsPnks9+s1YcGKonerWRS6x9VfA2qIzdeLdgwZIZF+heacXDyoIMm
   IEoONboNXQIGJdNb3TAEUoI+XOtpABgQQxiwicf7uV8z+p9f54c7RAn7E
   a8RFfdrlQsMprhi/NHOII1E2CfpuW6NSS9wb5lPU7Jo40MxwdN7wdzsfc
   mO0vD9ZcnduRMAiYII3dCxFthquNTq5o2w6yVKGqi2b4RWuifFzBN8Wvx
   Xi+llXYn0dPqjvu3C6fyGnq0WHzYMccpff0XeFX4IF71kfzaQngbcIAim
   RK0U71nv6k6+pEvzUIwzkF/SC7a4Pbzjz33LsWONwEkhWIa8d56e3deyk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252678596"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="252678596"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 16:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="594599248"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2022 16:20:46 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:20:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:20:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 16:20:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 16:20:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgHRVD23J4N9fSwa/zF6sC7miFlp+mOs/RHvu0J0NsmJ0JFuE4VU8BySTB5gHYefVP6Nh0YyPC80HWYlsDIl+sqc4jsyqmlfWKNSW4hsR3gkVpwxahewDzmei7mz6SDniT2wDYHN2BoN3lNqHxGZLVV59qYXU3WX+R2CtbUDQY3wqAHsc3OrNn504KT8wOa9aL7T0Izdj3FvNZL23B2lc2BiNc0vv9a8Wx5ZiIJKZZxuqTsiuzNcU328hZwxF9D7KpSOrFLgxurJOOdPnPpFvErOfiQ/m09XavzH6GCHfOTL2olaGNsHNznThd6Ku2lHFEXXDL8q1s5+e89iOlLBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY/6VxiIXfirwj/KGvh317zwIiLLhv+cOcDNX7+rXbc=;
 b=EnXPB8L/Ba/5vbkdbsfKNksH2DUON1Yi0rmDQ/5mgps9sm3rjzaJP7pVQAVeb4Ihkh9ssEH9sPRPAFK2M84+2Hm4MZDb08HWEHB5kzMk8g9FzHznVw2V6QkrKpBby9xXyiCESIfbQAlPC5h7fiJdRSb97+Mp5t5i2AlhXAKX5UoI7v8r9XwYmVncpEdI/pUvq5jbfts7uL1NcmXSXH70G9PFzVuVDwrXCOlfeKbKCDrkupBW+1nS3GSTDqRW7qBBA4dHp7xaC1xJ/Mpj4KLrXdCLzQgzwN9Sb4TA0DPemYzrZrnvUQknBbV//r/0UI2/d3+Su2/Rq+ckbGOtGrM13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 4 Mar
 2022 00:20:40 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 00:20:40 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYKWCMboctMLwByUuDsP0F5N+Bl6yo1LAAgADoPMCAABbUAIAElC3Q
Date:   Fri, 4 Mar 2022 00:20:40 +0000
Message-ID: <BN9PR11MB54830CC9AB0EB6737B1B1958E3059@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220224092242.127081-1-tianfei.zhang@intel.com>
 <DM6PR11MB381942D6F18C6518FE3556B585019@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB548388C1E086059E277F4C8BE3029@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819683BD840979FF8F6084885029@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819683BD840979FF8F6084885029@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 2b70bceb-8607-46f8-7046-08d9fd74d06b
x-ms-traffictypediagnostic: CY4PR11MB1256:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1256256A32BBF6B9C28C90ACE3059@CY4PR11MB1256.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1cPzgGjxh1d6ERAe+dQz8HvM9jQ+1N8k3k6mLaZ1RqLEu0rU4WnLRZkcOPU9OvVrGZDvUk0kde7Gca65GPcZCPjPCuYlHuVld+5CcY4+WczvKA2JVZBrM4RF0/2FWw566V0mCEeE/3wiHaaiWSkNI+3U+ZMHGmVnKcecGoR9UOACXlEL+vqF9YmMXjlaApUAlATolykBy65ePp6uRYKAi3ZEAj89k/81o5xr68dsBwIBCvdwuqwoAPDA1S2bRADem/qbGo8zq55XmL9922GVs5r/pEFhuENURmDkmX1RGbIDUOsn0xjvxKgDad6Cqc+UKz7H+1Cf3pHIkJiHU2fbQ2yldibOxcpDC0lyRgoQIS9sHQ3UFmk1sX6jWXssMywYpxs5xhSqu8u/mgtS3wAenuuHURkwt9HVsa9nosnGhbtOgeCdKuIe8lr0yK/DaxJioej6zry0HN8xSmnJrLauSNN5Q4QC5uHG+BpZ3yWHEioVIMGVTag+PyQngd0LuJikzenQzM4lGySNrvDAUsKPjiPqOoq3z4Q/eKCg46HMIq4mwtNbgprztfHuLkXK9rvSPBECKAsqE70J+ziBa2u1xVobYJxGpZ9vPKIO6gSYivV3lnfm8Sh5qSLGoyYSQUkMLJH10fyFLqLy+4Kmv+WXPksv4xgyQk2Lp02pKf2t9W2MeejxgLsuD8Rz2dhYza1c9bv1QUq2qZKyhd0pWOoIUoWJXROqRu3hUq4W4npbHs9K+JZJVXIbDzxM9BdeaU/FLWmJrCeEt2ckK5LjZ4YERoEP4PhZ6+hmZRkTMQgExPlgTj1dZYQTU6/j02aCEeUtVhRzJ7MPsvGvB3HsIY6jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(9686003)(316002)(8676002)(66946007)(38100700002)(33656002)(82960400001)(4326008)(76116006)(26005)(66446008)(122000001)(5660300002)(186003)(45080400002)(52536014)(66556008)(66476007)(38070700005)(508600001)(966005)(55016003)(8936002)(6506007)(7696005)(110136005)(53546011)(83380400001)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nZcWu8f4u95e4Huv/JCejeJH6LLhhMxX/9pl/YOy6sx6yAAoeKcDf+5aJhb2?=
 =?us-ascii?Q?w5L5e62BVygRBDLQK1KMNcKlyE79hrNXO8ab7ZX4dZcmokL0RYjSh2vc6TKt?=
 =?us-ascii?Q?9Q8AXc3nPhgQf2/TvSCRKunhUP6fY0i+WXgyr3rIN61gTpN332N/GP7GLOj8?=
 =?us-ascii?Q?eeJ6sffwNvTj1wzm3b/X/Qrv2nHtPczX+oDdV8dOpX7/IhtrEXOEDroI2nCd?=
 =?us-ascii?Q?p9grW+8WZ6n3GO4CT7vgzPQsXw0UVnJqMQ1nG/Ra1YHZge7qq+tThH6xGt8d?=
 =?us-ascii?Q?K7Edq9W9W4gnvzJ0IACimB395lvTg6vxBGitDEQ5YrrLvl+Lq1285rLFfA6q?=
 =?us-ascii?Q?jxAygE4jV0fs3kZmvc+immx0Qoxe0/GBK1Z/DZ5+b9iLEE4OY4CPHwEV9FlQ?=
 =?us-ascii?Q?VmoGjaoFtcZtCwLSj/m5r+BxKEP7PB30F0Yyv4sCJjkBLujYEhVq76OfFmLq?=
 =?us-ascii?Q?bZUI+TE8nOK6NTCRZB8ZX19oTVtiHJ3t7UZNgIvGmL/OE9AapkV4AxoBj7cF?=
 =?us-ascii?Q?tkf0vyF8fCXp+cL60NpUhhtwoKVKPKGFJQ09AYLqEdHpzCTgboSVpCrkj8r8?=
 =?us-ascii?Q?ZWYOM1758fseSnvK5r1E+Zr0x6hOsDMlvOV0tq2VvNu+lzjlMnl9KILYsCfA?=
 =?us-ascii?Q?zcHudOxrvRxwu6EVIjM7w8txUnKJoOpFMX5hH6jCNHi5MsaBofeRlPQ2t8LF?=
 =?us-ascii?Q?J4qfNtCmvYSX5csPMlaz1c0dvu7f8lGaabN9NnZ56j51i6eAKK8vu88IYzKz?=
 =?us-ascii?Q?5VlIxytv9340eFysZMtN1EDlB53CDSj8FaW3sqe0poy9hK7EhuBbXGXK/+68?=
 =?us-ascii?Q?RS+rlw8KYo0pOV7Nu6rvCT0MpiLsSn4y12Y/VBd2TXZZuaaee/pUNZEvwdpn?=
 =?us-ascii?Q?HH7QJw+7EDZxBD6QhBP4sNZJfuGhsDk2k03gWjpkgVzcSfLzpZsFaRb8aOEx?=
 =?us-ascii?Q?h2qfaEIa3KnaSIAeascUx+M3S9r/TjDKs30Jt7+TDHnlMdomSDaW54RfU1aM?=
 =?us-ascii?Q?NRvwGojkY9e0/zJV+5NJ/xDbB5kSJXX70VwRv24boqSFQx1ltumm8JMT0eBA?=
 =?us-ascii?Q?LurD54HnT9Z2rbnZdzfKGCjSgArah0D+/beuWDupwzImR+JDbY8NFD5uRGlL?=
 =?us-ascii?Q?3fH9DsOz1BY+d+TL/o3o3xH6fACefBvuJxCB7oMEyX4ce1l/C8IcODkSEzD2?=
 =?us-ascii?Q?EixGwdaaeVogxX9swHHsnSRfZuB9pa7pNTwsGhs5WPksAqyBj/etSzfdlhNu?=
 =?us-ascii?Q?ErW5JyWWU4Wsr0imLPYpnZSdxBQLkHhjCdkMpWHKKJf/5cQrzLQXQBSPf4M5?=
 =?us-ascii?Q?9jisKztJPpe8Ia3bdaAKV5sX4jqQgCsji6WAKCpoDzquIA1vJuCvPlTfiuRv?=
 =?us-ascii?Q?9IQWcVSbzQlNrPP8muir8v19UL9+VIFim8puryllf5tfVzsDa7IZWyixt5SH?=
 =?us-ascii?Q?U7ArgjoOfr9IrFU/Nw1bAx7e3ZPSCDWuumCxBRaXK0Y8EIu6QvhzAk33qSTw?=
 =?us-ascii?Q?bX8oX6OE4chahOk92uov4McPveuhVV3isvWQzEkDnpA6WlGL3r6rJaiQhxLY?=
 =?us-ascii?Q?H0585r0Hl0do5oCBOTD27wqCv0HyzLL9IaPU4HSyzw2XPPWpUUk6TcxS1u+d?=
 =?us-ascii?Q?qZwwFRX1SOzpLTebzAhg8NA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b70bceb-8607-46f8-7046-08d9fd74d06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 00:20:40.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iNRuhAqax3zYf0EWB50UtMZ9CPOLd3w1mfH+NHAsC5LCWy8HdzybxQOOt9MtRelXFzmNGP7wM0P0NgqzWpdoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
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



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Tuesday, March 1, 2022 10:23 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net
> Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq in=
fo
>=20
> > > -----Original Message-----
> > > From: Wu, Hao <hao.wu@intel.com>
> > > Sent: Monday, February 28, 2022 7:10 PM
> > > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
> > > linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Cc: corbet@lwn.net
> > > Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse
> > > irq info
> > >
> > > > Subject: [PATCH v1] fpga: dfl: check feature type before parse irq
> > > > info
> > > >
> > > > From: Tianfei Zhang <tianfei.zhang@intel.com>
> > > >
> > > > The feature ID of "Port User Interrupt" and the "PMCI Subsystem"
> > > > are identical, 0x12, but one is for FME, other is for Port. It
> > > > should check the feature type While parsing the irq info in
> > > > parse_feature_irqs().
> > > >
> > > > Fixes: 8d021039cbb5 ("fpga: dfl: parse interrupt info for feature
> > > > devices on
> > > > enumeration")
> > >
> > > Actually this is not a real bug, as in original design, there is no
> > > overlap for FME and Port features. This is why you see features for P=
ort
> doesn't start from 0.
> > But
> > > anyway I am good with such extension.
> >
> > I think this is a bug, I add some printk debug log in DFL driver, we
> > observed that
>=20
> Per original design, you should not use overlap feature IDs for FME and P=
ort as
> existing products. It extends the scope/rules of using feature IDs, for y=
our new
> cards, so to me, this is not a sw bug but extension.

Tom in the previous patch commented that this is a bug fix.

Hi Tom, do you agree this is extension or a DFL software bug?

>=20
> > it was mistaken for
> > the "Port User Interrput" feature device while we are parsing the FME
> > feature devices, so actually it read out the PMCI MMIO space for "Port
> > User Interrput".
> >
> > Here is the log:
> >
> > [90273.482859] parse_feature: DFH_TYPE_FIU [90273.482861]
> > parse_feature_fiu: id:0 fme [90273.482864] create_feature_instance:
> > feature id: 0xfe [90273.482868] parse_feature: DFH_TYPE_PRIVATE
> > [90273.482870] create_feature_instance: feature id: 0x1 [90273.482872]
> > parse_feature: DFH_TYPE_PRIVATE [90273.482874]
> > create_feature_instance: feature id: 0x7 ...
> > [90273.482895] create_feature_instance: feature id: 0x12
> > [90273.482898] parse_feature_irqs, PORT_UINT_DFH: 0x3000000200001012
> > [90273.482898] parse_feature_irqs, PORT_UINT_CAP: 0xbaadbeefdeadbeef
> > [90273.482899] dfl-pci 0000:b1:00.0: feature: 0x12, irq_base: 2779, nr_=
irqs:
> > 3823
> > [90273.482901] dfl-pci 0000:b1:00.0: Ignoring nvalid interrupt number
> > in feature
> > 0x12 6602 > 7
> >
> > >
> > > > Link: https://lore.kernel.org/linux-
> > > >
> > >
> >
> fpga/BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.nam
> > > > prd11.prod.outlook.com/
> > > >
> > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > ---
> > > >  Documentation/fpga/dfl.rst |  5 +++++
> > > >  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++------------=
----
> > > >  2 files changed, 27 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/Documentation/fpga/dfl.rst
> > > > b/Documentation/fpga/dfl.rst index ef9eec71f6f3..9ce418da1876
> > > > 100644
> > > > --- a/Documentation/fpga/dfl.rst
> > > > +++ b/Documentation/fpga/dfl.rst
> > > > @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature
> > > > driver with matched feature id.
> > > >  FME Partial Reconfiguration Sub Feature driver (see
> > > > drivers/fpga/dfl-fme-pr.c)  could be a reference.
> > > >
> > > > +Individual DFL drivers are bound DFL devices based on Feature
> > > > +Type and
> > > > Feature ID.
> > > > +The definition of Feature Type and Feature ID can be found:
> > > > +
> > > > +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feat
> > > > +ure-
> > > > +ids.rst
> > >
> > > Thanks for tracking ID allocations. could we also add some
> > > description that if user want to implement a new private feature,
> > > then they need to submit new
> > ID
> > > application to https://github.com/OPAE/linux-dfl-feature-id, and add
> > > some README file to guide people for the application process?
> >
> > That is a good point, I will add this for next version patch.
> >
> > >
> > > Thanks
> > > Hao
> > >
> > > > +
> > > >  Location of DFLs on a PCI Device
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >  The original method for finding a DFL on a PCI device assumed the
> > > > start of the diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > > index 599bb21d86af..6bff39ff21a0 100644
> > > > --- a/drivers/fpga/dfl.c
> > > > +++ b/drivers/fpga/dfl.c
> > > > @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> > > > build_feature_devs_info *binfo,  {
> > > >  	void __iomem *base =3D binfo->ioaddr + ofst;
> > > >  	unsigned int i, ibase, inr =3D 0;
> > > > +	enum dfl_id_type type;
> > > >  	int virq;
> > > >  	u64 v;
> > > >
> > > > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > > > +
> > > >  	/*
> > > >  	 * Ideally DFL framework should only read info from DFL header, b=
ut
> > > >  	 * current version DFL only provides mmio resources information
> > > > for @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> > > > build_feature_devs_info *binfo,
> > > >  	 * code will be added. But in order to be compatible to old versi=
on
> > > >  	 * DFL, the driver may still fall back to these quirks.
> > > >  	 */
> > > > -	switch (fid) {
> > > > -	case PORT_FEATURE_ID_UINT:
> > > > -		v =3D readq(base + PORT_UINT_CAP);
> > > > -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > > > -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > > > -		break;
> > > > -	case PORT_FEATURE_ID_ERROR:
> > > > -		v =3D readq(base + PORT_ERROR_CAP);
> > > > -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > > > -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > > > -		break;
> > > > -	case FME_FEATURE_ID_GLOBAL_ERR:
> > > > -		v =3D readq(base + FME_ERROR_CAP);
> > > > -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > > > -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > > > -		break;
> > > > +	if (type =3D=3D PORT_ID) {
> > > > +		switch (fid) {
> > > > +		case PORT_FEATURE_ID_UINT:
> > > > +			v =3D readq(base + PORT_UINT_CAP);
> > > > +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > > > +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > > > +			break;
> > > > +		case PORT_FEATURE_ID_ERROR:
> > > > +			v =3D readq(base + PORT_ERROR_CAP);
> > > > +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > > > +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > > > +			break;
> > > > +		}
> > > > +	} else if (type =3D=3D FME_ID) {
> > > > +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> > > > +			v =3D readq(base + FME_ERROR_CAP);
> > > > +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > > > +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > > > +		}
> > > >  	}
> > > >
> > > >  	if (!inr) {
> > > > --
> > > > 2.26.2

