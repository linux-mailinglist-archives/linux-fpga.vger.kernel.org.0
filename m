Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736344DC15F
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiCQIdz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCQIdy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 04:33:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF119EC65;
        Thu, 17 Mar 2022 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647505958; x=1679041958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88DYkusOAkQfGvZcM/mAadsyfUqJHP0l2FcRiS+Jxqk=;
  b=HdaPTg0/k/Z2886R+5jhGpd/UvaPJFg5eRSWSOFnl1MRQAPLKpmuqKUQ
   o4E2ZwmYLIfeDp+mjtu2orKof/8PsP1IlvseP67tuk38GTQec3eYDX2fx
   zgB7phpQx9NJtWtWZ7DmQK2hYBzXUjPEXQlcUCvrHFrJvqxZMtd6lw4So
   IQkrqfCjjBHpabF65wuTqCQKMHOh2GXyszwafK/K2mumAjTCywvyf03Ot
   5BgTjNYWemWuD25m18r/sG161JBWiR3+w4buf1a9e5c+YexNgFwjChydf
   heetcyYcB7J633I8rUruWLEyD5aAqZ+v2Q5RqZP75PFAHNdayz2S/qBz6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244269245"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244269245"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="690873057"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2022 01:32:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:32:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:32:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Iea4Yooe/XAr7Yn9pwfwEG7snRfrKt88Mmktvz7B4dCIIRwRpm+BHPPa1EvH1ubfgETKpn0xhbPv12+XEqKfsbap0pGGbUUEDeAMYIO11mLYQn+Sq5iwYLSJpO7IrC9CsVrBFKJih+6PFxvCbtNbHM2+IdQLbs7HvpTqnClmdhUJAhzpHlyDZAJVdAX7bUOTf+yzjljStMPEdTQuZdHN810V352cmvx7p1mL4soSk+dmxlAyefYxlC7exTme03FKDRpkGNAPUxFKwru6ye1FUKWxcAByUGXFnr0bXTKWq8BSHE3g2ubyBoSXKTq4zwLx7axoF9tTXH0iDUfEyvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkfDBMp2slxgrcnhv6+7udPC+dET3asi5rnOUCi/YYw=;
 b=TtM4cqwBdMmA4GXrNlhogWNiEbRe7mCPcOMH1e2YI8yEoPhdGkrkvx4ktOkmTuEnZKqKR+qzM2atVMUhe+vHGpKc1ArR5XdChVbZe5Vt8objY7oFQw8wKbFC775sFnuEVdcPX/YiG4zDnK9s4SFOiA/b8EG9ZDJHIp8gzOBdr7s1FZA24rtZ2qd54A41Ay/8OYuNmpscJboAGS57l7MVvMagLoXQP0YDGUucXQUhnOZ0A035N4HDNYa88YlCqR/oZrjBZNZ/wXULi5ITKmNEDNvwZJMKemawQIitJ8yZpSDs4CdOIql4KnQ18AOhtymXUG0BaYn/OW8thzzuAgi7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB3246.namprd11.prod.outlook.com (2603:10b6:805:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 08:32:32 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:32:32 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Topic: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Index: AQHYOQUcVwr1NO7I9EaBR7STlp8buqzC1K+AgABHRmCAACD9gIAAAOAA
Date:   Thu, 17 Mar 2022 08:32:32 +0000
Message-ID: <BN9PR11MB5483D95314F5D82F1EE31174E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-2-tianfei.zhang@intel.com>
 <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
 <BN9PR11MB54839B3ABC5844DF45602995E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB381901ED86051F8D3117799A85129@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381901ED86051F8D3117799A85129@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: c1a29cb7-26de-4a81-a4a5-08da07f0ae84
x-ms-traffictypediagnostic: SN6PR11MB3246:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB32461812A0DA7E89A4FC04ECE3129@SN6PR11MB3246.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/+Dy1r/nDgtRbLTHV1l4u5eifENp2z88zrbjDARmfPue3YzcvQBr1uwqqxh+PaOPS8vAs/J9ZjtcRD92yieMDTCFF2QcbVLmV/684/Rxle7o5l/sC3N0nQhjRuWqzEfl/kxBjTwesjeGJRVo+3fDBSQ+3heCunjnRdRfPU6bIKXkOOsfcoQuajM8XJn7O6RZBFozoCWYpjMt2EjTQ6lAyzXXipiGNUsW2gZa+jtNwZRQ/s07CUe2OzYdfghR3A/bz+OIuyyTz9+/FbmvZmjFXlqJOgx3hhsXVQ5iMo8F/B/Ucejlsd20bQ0KTpUMQTtMhVGRKbFM7ikFix6XANaD8F59KJv37EYi/MzoPrg5928+210JW/02mtnewkcp+CjgL49joGGpYhT5ztGCTzv0TjNoQDdidkvKqgjz/HLI3KP8WR9ykIqfzTAzqduicqPqvCj4OR3w03YBS4wHw07KqFZVjaRu3JMhUKRga04oENWORxBUJdod0ESCTDkgMsQmC/9/SsP4z1od1Dd/c+hk0Z3dDMi72qxRdx33VLhG5Zet7YoFIdqespNmNzAkDMShVa6c0Z5ZzORAztndToKOZQyy/+75Urz7QRg1a6tE+D6PqSydLMBRCRj0wRslOmJewMzKDeKUG+hp0aDDUMDHZ2C9kftJ878077dLVIqEgdsZh0im2cQB6WeyQrVdeZlJnN7+V9nvoyRrCbZ/dZDKLQhHaskYSdFztaMd/7sFos=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(2906002)(508600001)(4326008)(64756008)(66446008)(66476007)(66556008)(8676002)(55016003)(66946007)(110136005)(54906003)(71200400001)(86362001)(33656002)(7696005)(6506007)(53546011)(9686003)(316002)(26005)(186003)(83380400001)(122000001)(921005)(38100700002)(82960400001)(38070700005)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SZqxnjVboDq4QmVwOjUOvxbTzSpcHMdlP1ZZE/6r4LsOcCfqQq1YJJbokK0w?=
 =?us-ascii?Q?nGv2R212SF2qc35gy1yxxKyhC5xr5xK1htCPseTyfuiDpofhUV/+o6sC/sDv?=
 =?us-ascii?Q?95vg3w+eRJN7Pc8wOj/xvu0fHM060orWyxyxc3+MCm4OKvo7j9WM+Z/cTfWU?=
 =?us-ascii?Q?GpiwRyMaKQP9K/9NpBFO4J4/CatHOD2z5fZs9BEcU6P8ioV1DTfRo17LKLhA?=
 =?us-ascii?Q?ikpMTHGgAWegBrh4YI2FbXRBEvAWth/r0oF5f9WXDu9Q2R73iJ0zo2Y6is54?=
 =?us-ascii?Q?GOiDcwznZlfscNjIhejC7pS1I9hhuOjOCGgZhXKzqVDTlsRY+oXGIzMzBw/p?=
 =?us-ascii?Q?DNi+6fmrBCCByYHsZ6eKrJ0ROdyil7Fuy42nc0LMd1rJJGDQngQO5ZJIATlg?=
 =?us-ascii?Q?1xv5emHdNOLoX9AvboX4oFuZL5+zfp8SJPVR4bate0bp2HsyKprQTalnMlb1?=
 =?us-ascii?Q?NOBTDmS0KqIZo4WiXEwJDJHXogRLSrbbCq0xjCLl3lXyw5glPWm4Tq6Cg7WD?=
 =?us-ascii?Q?WOIFCWUDHJGuTE1tUBpScj/R7ERULHPlAoNx0fJHIjFz7UMzQqulQO1ijB+K?=
 =?us-ascii?Q?oWqznlXYEGh8chi8ruSsLCK1+xxh4n9J5oDncpvO1Mnjz2LKjNOaz8y7ek2r?=
 =?us-ascii?Q?1KtdBJKdOy8hybTaGI2HSd7ljYKHCiPSLjZnbBj/yENTG/IcX86kqKRmrebW?=
 =?us-ascii?Q?aJM7iNQl5BugvAoQb4mlO3hceIydzOWJFwBSTZSiguyMYW/Ggmdco6zSUJVE?=
 =?us-ascii?Q?dUs/olEBOnTvd+f1pb4fkNoTG/lg3Ph1lYA3sCHN6rms9e575OrYHkXwE+SF?=
 =?us-ascii?Q?B6g21Vf/oAmFXiHqlALWBdkUTkDeGbncd3P8AFLNxIIBuCZJxLmp0vZKYgvZ?=
 =?us-ascii?Q?hcaVhqEQ9P6JU0sSlencfC/XQJubw+Nd1ltWkmklvrAu0ppKZrjRNzN/IJ8t?=
 =?us-ascii?Q?i4/MkQC1kMzmj7Es0YTz693Oc0aBCTNQpdjdQ9B66mjJhsko/GE0YRkhTq3V?=
 =?us-ascii?Q?/holqaOXMW4aGGeTSKFucL3DKEN6AC1hHbYfrWboQP93Ywv/y0ML2d3koe71?=
 =?us-ascii?Q?EHkg5CIcMZmggba0v6qtiuBHeHcZPQJHZoetXl+Fb0Scm2mAogdF3adk+Jau?=
 =?us-ascii?Q?9JS/t68FVTuIBP4LkXATG57b2jF9nuehjiiOLx3FENgK/gmDma5Ae18lh0AI?=
 =?us-ascii?Q?SlFhMi41JPgJmq5sJ6JYygVMhlV+quGD+j5u23UdKm1ib1gXorESxjIjhflC?=
 =?us-ascii?Q?DuDk/SpNnN1Z6dnKHqvL08FiXO6uKAbYOHJHqx7fXYrC7GvHAZ7p7Mpa8Cm6?=
 =?us-ascii?Q?UDMdzeQex0Wkae12Va9RgLKo90v4hJFZEyn6oqrVW8ZAskW5+TByO8hb5Ghz?=
 =?us-ascii?Q?uK3a48wh8pUp7kbHDvohrvYs5rZxiSsmOtvxxQrGp/vVeS+9B2+4pb1D7/V7?=
 =?us-ascii?Q?GafPHazVnCNb34dXwd3IfjDIT+/ApJF7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a29cb7-26de-4a81-a4a5-08da07f0ae84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:32:32.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANT3Yc39RtIRDKOnqviuZBMdJCUiSjDI+ko3091+xjRihMLOpF6r316oxu2E0e5ElroXynCzjjuZUDjj8+zBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3246
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, March 17, 2022 4:18 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar spac=
e.
>=20
> > > -----Original Message-----
> > > From: Wu, Hao <hao.wu@intel.com>
> > > Sent: Thursday, March 17, 2022 10:05 AM
> > > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
> > > linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; rdunlap@infradead.org
> > > Cc: corbet@lwn.net; Matthew Gerlach
> > > <matthew.gerlach@linux.intel.com>
> > > Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar =
space.
> > >
> > > > -----Original Message-----
> > > > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > > > Sent: Wednesday, March 16, 2022 3:08 PM
> > > > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org;
> > > > Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > > > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > rdunlap@infradead.org
> > > > Cc: corbet@lwn.net; Matthew Gerlach
> > > > <matthew.gerlach@linux.intel.com>;
> > > > Zhang, Tianfei <tianfei.zhang@intel.com>
> > > > Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar sp=
ace.
> > > >
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >
> > > > In OFS, each PR slot (AFU) has one port device which include Port
> > > > control, Port user clock control and Port errors. In legacy model,
> > > > the AFU MMIO space was connected with Port device, so from port
> > > > device point of view, there is a bar space associated with this por=
t device.
> > > > But in "Multiple VFs per PR slot" model, the AFU MMIO space was
> > > > not connected with Port device. The BarID (3bits field) in
> > > > PORTn_OFFSET register indicates which PCI bar space associated
> > > > with this port device, the value 0b111 (FME_HDR_NO_PORT_BAR) means
> > > > that no PCI bar for this port device.
> > >
> > > The commit message is not matching the change, it's not related to AF=
U...
> > >
> > > Current usage (FME DFL and PORT DFL are not linked together)
> >
> > This usage is only on Intel PAC N3000 and N5000 card.
> > In my understand, the space of Port can put into any PCI bar space.
> > In the previous use case, the space of port was located on Bar 2.
> > For OFS, it allows the port without specific bar space.
>=20
> I didn't understand what you mean. Without your change, existing driver
> supports Port in any BAR indicated by PORTn_OFFSET, it's fine you put Por=
t to
> BAR 0, or same BAR as FME. What do you mean by "port without specific bar
> space"?

"port with specific bar space" means that the port has a dedicated bar spac=
e, including the DFL, AFU, this is use=20
case in N3000/N5000 card.

"port without specific bar space" means the port without specific bar space=
, and the Port linked with FME for DFL
perspective.

>=20
> >
> > >
> > > FME DFL
> > > PORT DFL (located by FME's PORTn_OFFSET register, BAR + offset)
> > >
> > > Your proposed new usage is (FME DFL and PORT DFL are linked
> > > together)
> > >
> > > FME DFL -> PORT DFL
> > > So FME's PORTn_OFFSET can be marked, then driver could skip it.
> > >
> > > Is my understanding correct? If yes, please update your title and
> > > commit message, and add some comments in code as well.
> >
> > From DLF perspective, I think it is yes.
> >
> > How about the title:  "fpga: dfl: Allow Port and FME's DFL link togethe=
r" ?
>=20
> "Allow Port to be linked to FME's DFL" should be better, as we don't enco=
urage
> that people to connect FME DFL to Port DFL or any mixed order.

Looks good.

>=20
> >
> > I will also add some comments in code.
> > Here is the new git commit for this patch, any comments?
> >
> > In previous FPGA platform like Intel PAC N3000 and N5000, The BarID
> > (3bits field) in PORTn_OFFSET register indicated which PCI bar space
> > was associated with this port device. In this case, the DFL of Port
> > device was located in the specific PCI bar space, and then the FME and
> > Port's DFL were not linked. But in OFS, we extend the usage, it allows
> > the FME and Port's DFL  linked together when there was no local PCI
> > bar space specified by the Port device. The value 0b111
> > (FME_HDR_NO_PORT_BAR) of BarID means that no specific PCI bar space
> > was associated with the port device.
>=20
> Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
> connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device)=
,
> PORT DFLs are connected to FME DFL directly, so we don't need to search P=
ORT
> DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> (FME_PORT_OFST_BAR_SKIP/INVALID - depends the description added to DFL
> spec) then driver will skip searching the DFL for that port.

It is good for me.

>=20
> >
> > >
> > > Again, the change you did in dfl core code, is not only impacting
> > > your OFS device, but also future DFL devices, it's an extension to DF=
L.
> >
> > Yes, I agree that is an extended usage.
>=20
> Please make sure related changes documented in DFL spec as well.

I will add it on documentation.

>=20
> >
> > >
> > > Thanks
> > > Hao
> > >
> > > >
> > > > ---
> > > > v3: add PCI bar number checking with PCI_STD_NUM_BARS.
> > > > v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
> > > >
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > ---
> > > >  drivers/fpga/dfl-pci.c | 7 +++++++
> > > >  drivers/fpga/dfl.h     | 1 +
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > > > 4d68719e608f..2e9abeca3625 100644
> > > > --- a/drivers/fpga/dfl-pci.c
> > > > +++ b/drivers/fpga/dfl-pci.c
> > > > @@ -258,6 +258,13 @@ static int find_dfls_by_default(struct
> > > > pci_dev
> > *pcidev,
> > > >  			 */
> > > >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > > >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > > +			if (bar >=3D PCI_STD_NUM_BARS ||
> > > > +			    bar =3D=3D FME_HDR_NO_PORT_BAR) {
> > > > +				dev_dbg(&pcidev->dev, "skipping port without
> > > > local BAR space %d\n",
> > > > +					bar);
> > > > +				continue;
> > > > +			}
> > > > +
> > > >  			start =3D pci_resource_start(pcidev, bar) + offset;
> > > >  			len =3D pci_resource_len(pcidev, bar) - offset;
> > > >
> > > > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > > > 53572c7aced0..1fd493e82dd8 100644
> > > > --- a/drivers/fpga/dfl.h
> > > > +++ b/drivers/fpga/dfl.h
> > > > @@ -91,6 +91,7 @@
> > > >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> > > >  #define FME_HDR_BITSTREAM_ID	0x60
> > > >  #define FME_HDR_BITSTREAM_MD	0x68
> > > > +#define FME_HDR_NO_PORT_BAR	7
> > > >
> > > >  /* FME Fab Capability Register Bitfield */
> > > >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > > > version ID */
> > > > --
> > > > 2.26.2

