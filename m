Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7DA55292A
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 03:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244938AbiFUBzz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUBzx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 21:55:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71719C1C;
        Mon, 20 Jun 2022 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655776552; x=1687312552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CNm4LzngZDuWX3Gyw83Vt0mR7VQEjducSn5pFivlrNc=;
  b=lIYLKaGHFyJaRIEwFnrGAZxrcl9bbgxFhwtw6l6X6djr2T55JL9X3PJ4
   UhVBmIZIGOPnSOt4TpqDUjirytU0YYlqVMGOiZcCJXHX3IjJjOu33UUqG
   JgM9pECetp3ebmqbxKwwiVHDzPZDM/An24xjB1qizYwPGLNzPEPFFrN6l
   YFAnVnh21bxOZdCSkJkn+anromj16L0OaDyGtgtOkZHmxcD1yRloAExNC
   0l+RWzX2+bJkp2qoems/T1iAg7ylXgbBM+mRqRQNor4cRYn26+EqaIeH6
   zwYfUK4OiPu+nhEkZ8SUjKhqMw5fMI3b8bQwZAhy+LHka692KxnT43LCw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280733976"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280733976"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="654924741"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2022 18:55:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 18:55:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 18:55:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 18:55:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 18:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlHd9VEpE0CWSImmTNXZCsQMcDIR7kFgnc1eln7H/gUOy2p9YeV9dYf3B7yDflyXn+mIUsybezaz3/+nctHvhRyFNIqfiZ76TmQkS54Q2mKWdx5v3zHoSTMPClKLh8/niVd+pxkoiDlIybvSsOUDLjP0qDTBD1I/eEpTUhDh7xF1ssIUloEZGkv5EmTQ0KdalQPObwAj9jkXMlD4kbCrN6lKVLPlqhaaJChGQZEldAnS2FYUq2NaVRfqvxrfKgwod4I93QdQnzQ2Hctd+JLMbLeHfnZBsPqemF1zaH9CHufb0N4yqCo1JJexkQr0XPC0lDrmJ/D62Mig4z+oZzoWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbOSMFLppqFFGfrBV/tf+/xTUgGS5cnp1i/cidGTY24=;
 b=d8OE+BI8DTw6EMqVZzDueimZneK81L9G4bkafmX5OTupLHX+gAgMPzifUVW87kiCQ7LOgDHv9KLR9PCmvS7lsqpX2klMuEzxTCr7PVdrJ3hm077uLxkH0iuejHyvqDNED7SqJi7w1a2gu/Y+/dNMODmW3+s3LX+vcUZwcmwDi92G0JcJW+/zY8+xQfDog+kaRAr7GKEoVAbvC96bHFfwxtH2fGbDfFMPqzvOderptO44jr84iqTXT6Pk+OQbHMLw3jByEA1n4TIVjBa3Jernub16yGu2AUnRMjRrFpo2xlWHewi4kgWVVaCJj14qlTCnZ7vqI6sQlhjyHiDZFvTmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MWHPR1101MB2158.namprd11.prod.outlook.com (2603:10b6:301:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 01:55:45 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:55:45 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2 3/4] mfd: intel-m10-bmc: add PMCI driver
Thread-Topic: [PATCH v2 3/4] mfd: intel-m10-bmc: add PMCI driver
Thread-Index: AQHYge8UCDWIESBmw0Stb3CHzsk37K1YNU4AgADbEXA=
Date:   Tue, 21 Jun 2022 01:55:45 +0000
Message-ID: <BN9PR11MB5483F92AB1EBE056982C5E1BE3B39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-4-tianfei.zhang@intel.com>
 <20220620115508.GC1319418@yilunxu-OptiPlex-7050>
In-Reply-To: <20220620115508.GC1319418@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ee7ea8-d40e-4a1d-f09c-08da532927c3
x-ms-traffictypediagnostic: MWHPR1101MB2158:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR1101MB2158363A26E40CCF4F76F29EE3B39@MWHPR1101MB2158.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Q9ddMMTG8EegyvckjsXgiSzLL15VCRGBd9EiTwwBzQWqTq5C0DaMWaNESnOoRzH4yfmHvMhzx15dsf+hZAIVzHYyoAAA1O+2tFom+SzAvxb7ywrGO535MNQEaZGWMqjZ1LikCqXI0LI18j0Mwbp93QvBodTIXyZzJClj7/hakiJ0tlfaMtg58U3rYIFue5p3nk6HuJTHoo9KvXFy4l9DGHjmrz4hk9q69+hzqS9iMWIS/q+1pq0wrt0b69KY6jW1kVKrSaNjaBX5SdSVJcPPraoGSB4dxGyS3tmbNWMD6wFWx/VTenvRd34IGwTlhHYBJjf3NaBE6g4snhEeeXKnOM8GD/Fh3A6Gpxa+++SJ0QlS54g26ViM0PBTs3lRaTQLYWCzYEMjbwMcZMhmcCKTtEVRvN43bxhPuHg+7+9PTow+GuiiCDysr7632xv3eCOCnZIXV1DRPwkdc8eHKPm1lqiHQDwZBfr8ZbWzs7zfkDRo+JK1OZYnPvNQL3iRNRQUXQdROZUoaPyAvEFTmzBmsZI3dee+aqWlhnISWvTsNyTlVRgqYhCciki/DSBRjBVd3oJRHjyyPWIqm1QTW4VKRvxvXd4aLmqRDx4ZWnyfyti6+9Mv99Qq0hncip3UGre/TkuOLzmwyC7iIrOYEkTcF+O439C2cQX7oI15ub/pR6afW8Tf34xtGHsLOyJZbqGb6IwrBDlDCMv9wpwB/LsoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(346002)(39860400002)(71200400001)(66556008)(478600001)(186003)(33656002)(76116006)(66476007)(66446008)(5660300002)(64756008)(6506007)(7696005)(316002)(8676002)(66946007)(83380400001)(52536014)(53546011)(2906002)(41300700001)(30864003)(4326008)(6862004)(122000001)(8936002)(82960400001)(38100700002)(86362001)(55016003)(6636002)(9686003)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HQf8jlWPq1/J0fc7H3HuKrUcBc3GLxGurBIlAioMSato1qBf+Pn/2YZ/gdz7?=
 =?us-ascii?Q?TlTPXA+uv4d+4vz13xPYv+L0uEPLCRIC8vxRvaDnauNoUsCJI++VFZGRu7GE?=
 =?us-ascii?Q?rX8I4z/gIwLTker+WwX0cNnUD5/PU6HbNrDno4qyYxlH1ldwBFQ7fhyvR2Si?=
 =?us-ascii?Q?bGBEx98RNCTnewlE9kPZ/MWZHBVOkBz1y8G6WXBDQycqdVI0TrCMO4etbODv?=
 =?us-ascii?Q?NBh7tIdnI1pwFFlnat5z1cPE98jpGE4lymQNvzKYohzNu/WHXnXzBWFQg1Bl?=
 =?us-ascii?Q?VdgXZ1JUswBbIf3Pl6LWPYeBQrx5neDaLpOZv63dwZ1qcfQJUUjD98AEfHnq?=
 =?us-ascii?Q?pdA1SKs4C3pFiLAGHpsylPY3Fu25PFLJkuAXMQRGCIH3xlY6lxkXzpuFSl46?=
 =?us-ascii?Q?2IrLVnG0CwWdbGFuO9M3rqyQkHiNAVx0yjYiCqj8K1MPKC+4QiwWveXhct/7?=
 =?us-ascii?Q?aHZdnLRlSZFoHlPJ0gyfqPVWpisJVIMkaPvNudj2FHTr1mHxviQBSnqva5iZ?=
 =?us-ascii?Q?MPXN+bzCFmb3psfC8mumP1BUa7DoeXacnPRkqfcuuTjsWG4mEeYUraP1M3sZ?=
 =?us-ascii?Q?x2CvhN9B1x6fYw7kNPPWk+vw3UmOFqV2HAmrTuYoiIf/kLNR4X+eo0P3oSJE?=
 =?us-ascii?Q?I3dyS4k8oi2mD+3uoBHvd1JDk5qsgi384sQdjWLl7Ni7jfA8nOLv7VKJtimD?=
 =?us-ascii?Q?BE9y654vkTCXw1bnFgwWpakYFoh7U7I6xDRYnusCuyEjcONCw4+cuXA1+9DE?=
 =?us-ascii?Q?JCCQ8v3YLdQfefTc2SPbOMbfVUhgkBAVSmA7p3T0abkm5iroWjElwbPvcax5?=
 =?us-ascii?Q?nNVb77RNQvXjbhpfgVAhLLkDqFy9eZZbd9W7/Ft2YQrBXhVx+dHwwObEtA4W?=
 =?us-ascii?Q?IBFG4qvAQBd/30KBnku8ZaU1UN1xfgNQ37Qdb0+ymXOwAvlyPMftDvCrqgJX?=
 =?us-ascii?Q?DFyU0APwoWxL77YzQWxzugovV4eQSx9P9gs1jy2seevOqNll3CSJjnjnMVTD?=
 =?us-ascii?Q?hzbP6kjApcJo/NMr//MKjnoDH6dVLA4bagdimEm5/UlhJ9kLMIBoykCeCunD?=
 =?us-ascii?Q?Hv0xrLjuPdOtGdShNe1baKT/bjDGAXJR4pqpLCxbVpbJzdwyOEDfT8iQucVn?=
 =?us-ascii?Q?h2XRiBGqjpGRWmZxfRqx5qUzJe1fC1CfmhQH7l7Dp04YBEoXzNGVZk4oCxM2?=
 =?us-ascii?Q?5wpIOi/ppaGCCU6w1XAyIh12WeSOW72UaOJcW8tcD3pzPqpJVcMZYHFKm3Il?=
 =?us-ascii?Q?pniP5RMu36se1n7NdMkH2v7694xKZRRMiFx7YPBObjxxEfYEfZemNqUpAY3r?=
 =?us-ascii?Q?0XPuO5G5tYcLKfLJ9Za1vzeJdm3fAzdBfhre8H0CjA7J5O9/8MRW2QCBj0Ls?=
 =?us-ascii?Q?mBYMHLuwI78ZYPMSAUbuRuTBZ654+8PcWPBegQI9oo6GIpyxhbC3NQKIjQeT?=
 =?us-ascii?Q?vvgKtBb+xPKQBbAV4zANdG+qpKLIwM3fg1baaWYLaBgUFysWNt4iji8H4Kp1?=
 =?us-ascii?Q?sF+8TOo3KXVfTMSGZJ5nEe7nQD0nrJmSuQ0sdP6LAw5PeNRWdT4JI5H7yR+2?=
 =?us-ascii?Q?BgInn0fyxoiw9GkqGxIVHGErlgWatNxVcf1YZ+ODrIcajGaj9ajClKWlzaN/?=
 =?us-ascii?Q?GBeJDWGt6cfQiAyl09/Pd2J9dImJkOL35tpERUol/sGWIk+PuNw3YzFT3vCz?=
 =?us-ascii?Q?5uzchg671DyDIiuN2uRfrshR9gd2GoRFhTeBOj7KAmW6vyK0n4pGHbHK1ZIJ?=
 =?us-ascii?Q?Mn3Cw1Gb72gJXxwBvbmrI64j+g+Fmn27/tG7tv0RawsGwNeTrTCdB15WaACA?=
x-ms-exchange-antispam-messagedata-1: Y9N6piLgB/BtDw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ee7ea8-d40e-4a1d-f09c-08da532927c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 01:55:45.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJRvDpibnpLa/rFrDIRoIi6iIpr4z6lUHnvKdHEFC6RuPwqkoBfSrO/mCBOIIiUN6A9fffDHYrFyz/puxkVpbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2158
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Monday, June 20, 2022 7:55 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: lee.jones@linaro.org; Wu, Hao <hao.wu@intel.com>; trix@redhat.com;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Weight, Russell=
 H
> <russell.h.weight@intel.com>; matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v2 3/4] mfd: intel-m10-bmc: add PMCI driver
>=20
> On Thu, Jun 16, 2022 at 10:04:04PM -0400, Tianfei Zhang wrote:
> > Adding a driver for the PMCI-base interface of Intel MAX10 BMC
> > controller.
> >
> > PMCI(Platform Management Control Interface) is a software-visible
> > interface, connected to card BMC which provided telemetry and mailbox
>=20
> The PMCI interface or the BMC provides the telemetry functionality?
>=20
> Maybe you should first describe the basic register access functionality f=
or PMCI
> interface. This is the main purpose of this patch.

Yes, I agree, the telemetry was provided by BMC via PMCI.

>=20
> > functionalities. On the other hand, this driver leverages the regmap
> > APIs to support Intel specific Indirect Register Interface for
> > register read/write on PMCI.
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > ---
> > v2:
> >   - fix compile warning reported by lkp
> >   - use regmap API for Indirect Register Interface.
> > ---
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
> >  drivers/mfd/Kconfig                           |  12 ++
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel-m10-bmc-core.c              |  19 +-
> >  drivers/mfd/intel-m10-bmc-pmci.c              | 190 ++++++++++++++++++
>=20
> Refering to intel-m10-bmc-spi.c, this is the DFL bus driver, PMCI is just=
 its
> internal register accessing implementation.
>=20
> So maybe intel-m10-bmc-dfl.c?

If we have other bus interface like I2C in future,  "intel-m10-bmc-i2c.c" i=
s better.
Like this, PMCI is other bus interface, I think " intel-m10-bmc-pmci.c" wil=
l be better.

>=20
> >  include/linux/mfd/intel-m10-bmc.h             |   8 +
> >  6 files changed, 230 insertions(+), 8 deletions(-)  create mode
> > 100644 drivers/mfd/intel-m10-bmc-pmci.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > index 9773925138af..a8ab58035c95 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > @@ -1,4 +1,4 @@
> > -What:		/sys/bus/spi/devices/.../bmc_version
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmc_version
>=20
> The same driver for both PMCI & spi? From your patch, the pmci driver is =
named
> "dfl-pmci-bmc", is it?

Yes, the path is for both PMCI and SPI.  This is should be "dfl-pmci-bmc".=
=20

For PMCI driver:
/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/ bmc_version
For SPI driver:
/sys/bus/spi/drivers/intel-m10-bmc/spi0.0/bmc_version

So this path should be:
/sys/bus/.../drivers/.../.../bmc_version

>=20
> >  Date:		June 2020
> >  KernelVersion:	5.10
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > @@ -6,7 +6,7 @@ Description:	Read only. Returns the hardware build
> version of Intel
> >  		MAX10 BMC chip.
> >  		Format: "0x%x".
> >
> > -What:		/sys/bus/spi/devices/.../bmcfw_version
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmcfw_version
> >  Date:		June 2020
> >  KernelVersion:	5.10
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > @@ -14,7 +14,7 @@ Description:	Read only. Returns the firmware
> version of Intel MAX10
> >  		BMC chip.
> >  		Format: "0x%x".
> >
> > -What:		/sys/bus/spi/devices/.../mac_address
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
> >  Date:		January 2021
> >  KernelVersion:  5.12
> >  Contact:	Russ Weight <russell.h.weight@intel.com>
> > @@ -25,7 +25,7 @@ Description:	Read only. Returns the first MAC
> address in a block
> >  		space.
> >  		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> >
> > -What:		/sys/bus/spi/devices/.../mac_count
> > +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
> >  Date:		January 2021
> >  KernelVersion:  5.12
> >  Contact:	Russ Weight <russell.h.weight@intel.com>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > ee8398b02321..7300efec3617 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2177,6 +2177,18 @@ config MFD_INTEL_M10_BMC_SPI
> >            additional drivers must be enabled in order to use the funct=
ionality
> >            of the device.
> >
> > +config MFD_INTEL_M10_BMC_PMCI
> > +	tristate "Intel MAX 10 Board Management Controller with PMCI"
> > +	depends on FPGA_DFL
> > +	select MFD_INTEL_M10_BMC_CORE
> > +	select REGMAP_INDIRECT_REGISTER
> > +	help
> > +	  Support for the Intel MAX 10 board management controller via PMCI.
> > +
> > +	  This driver provides common support for accessing the device,
> > +	  additional drivers must be enabled in order to use the functionalit=
y
> > +	  of the device.
> > +
> >  config MFD_RSMU_I2C
> >  	tristate "Renesas Synchronization Management Unit with I2C"
> >  	depends on I2C && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> > b5d3263c1205..a8ffdc223cf7 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -270,6 +270,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+=3D simple-
> mfd-i2c.o
> >  intel-m10-bmc-objs             :=3D intel-m10-bmc-core.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   +=3D intel-m10-bmc.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   +=3D intel-m10-bmc-spi.o
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)  +=3D intel-m10-bmc-pmci.o
> >
> >  obj-$(CONFIG_MFD_ATC260X)	+=3D atc260x-core.o
> >  obj-$(CONFIG_MFD_ATC260X_I2C)	+=3D atc260x-i2c.o
> > diff --git a/drivers/mfd/intel-m10-bmc-core.c
> > b/drivers/mfd/intel-m10-bmc-core.c
> > index f6dc549e1bc3..c6a1a4c28357 100644
> > --- a/drivers/mfd/intel-m10-bmc-core.c
> > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > @@ -10,6 +10,11 @@
> >  #include <linux/mfd/intel-m10-bmc.h>
> >  #include <linux/module.h>
> >
> > +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] =3D {
> > +	{ .name =3D "n6000bmc-hwmon" },
> > +	{ .name =3D "n6000bmc-sec-update" }
> > +};
> > +
> >  static struct mfd_cell m10bmc_d5005_subdevs[] =3D {
> >  	{ .name =3D "d5005bmc-hwmon" },
> >  };
> > @@ -146,10 +151,12 @@ int m10bmc_dev_init(struct intel_m10bmc
> *m10bmc)
> >
> >  	dev_set_drvdata(m10bmc->dev, m10bmc);
> >
> > -	ret =3D check_m10bmc_version(m10bmc);
> > -	if (ret) {
> > -		dev_err(m10bmc->dev, "Failed to identify m10bmc
> hardware\n");
> > -		return ret;
> > +	if (type =3D=3D M10_N3000 || type =3D=3D M10_D5005 || type =3D=3D M10=
_N5010) {
> > +		ret =3D check_m10bmc_version(m10bmc);
> > +		if (ret) {
> > +			dev_err(m10bmc->dev, "Failed to identify m10bmc
> hardware\n");
> > +			return ret;
> > +		}
> >  	}
> >
> >  	switch (type) {
> > @@ -165,6 +172,10 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
> >  		cells =3D m10bmc_n5010_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_n5010_subdevs);
> >  		break;
> > +	case M10_N6000:
> > +		cells =3D m10bmc_n6000_bmc_subdevs;
> > +		n_cell =3D ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> > +		break;
> >  	default:
> >  		return -ENODEV;
> >  	}
> > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c
> > b/drivers/mfd/intel-m10-bmc-pmci.c
> > new file mode 100644
> > index 000000000000..249a2db5e742
> > --- /dev/null
> > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > @@ -0,0 +1,190 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PMCI-based interface to MAX10 BMC
> > + *
> > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > + *
> > + */
> > +
> > +#include <linux/dfl.h>
> > +#include <linux/mfd/intel-m10-bmc.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#define M10BMC_PMCI_INDIRECT_BASE 0x400
> > +#define INDIRECT_INT_US        1
> > +#define INDIRECT_TIMEOUT_US    10000
> > +
> > +#define INDIRECT_CMD_OFF	0x0
> > +#define INDIRECT_CMD_RD	BIT(0)
> > +#define INDIRECT_CMD_WR	BIT(1)
> > +#define INDIRECT_CMD_ACK	BIT(2)
> > +
> > +#define INDIRECT_ADDR_OFF	0x4
> > +#define INDIRECT_RD_OFF	0x8
> > +#define INDIRECT_WR_OFF	0xc
> > +
> > +struct indirect_ctx {
> > +	void __iomem *base;
> > +	struct device *dev;
> > +	unsigned long sleep_us;
> > +	unsigned long timeout_us;
> > +};
> > +
> > +struct pmci_device {
> > +	void __iomem *base;
> > +	struct device *dev;
> > +	struct intel_m10bmc m10bmc;
> > +	struct indirect_ctx ctx;
> > +};
> > +
> > +static int pmci_indirect_bus_clr_cmd(struct indirect_ctx *ctx) {
> > +	unsigned int cmd;
> > +	int ret;
> > +
> > +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> > +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > +				 (!cmd), ctx->sleep_us, ctx->timeout_us);
> > +	if (ret)
> > +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn",
> __func__,
> > +cmd);
> > +
> > +	return ret;
> > +}
> > +
> > +static int pmci_indirect_bus_reg_read(void *context, unsigned int reg,
> > +				      unsigned int *val)
> > +{
> > +	struct indirect_ctx *ctx =3D context;
> > +	unsigned int cmd;
> > +	int ret;
> > +
> > +	cmd =3D readl(ctx->base + INDIRECT_CMD_OFF);
> > +	if (cmd)
> > +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> cmd);
> > +
> > +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > +	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
> > +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > +				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> > +				 ctx->timeout_us);
> > +	if (ret) {
> > +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n",
> __func__, reg, cmd);
> > +		goto out;
> > +	}
> > +
> > +	*val =3D readl(ctx->base + INDIRECT_RD_OFF);
> > +
> > +	if (pmci_indirect_bus_clr_cmd(ctx))
> > +		ret =3D -ETIMEDOUT;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int pmci_indirect_bus_reg_write(void *context, unsigned int reg=
,
> > +				       unsigned int val)
> > +{
> > +	struct indirect_ctx *ctx =3D context;
> > +	unsigned int cmd;
> > +	int ret;
> > +
> > +	cmd =3D readl(ctx->base + INDIRECT_CMD_OFF);
> > +	if (cmd)
> > +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> cmd);
> > +
> > +	writel(val, ctx->base + INDIRECT_WR_OFF);
> > +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > +	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
> > +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > +				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> > +				 ctx->timeout_us);
> > +	if (ret) {
> > +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n",
> __func__, reg, cmd);
> > +		goto out;
> > +	}
> > +
> > +	if (pmci_indirect_bus_clr_cmd(ctx))
> > +		ret =3D -ETIMEDOUT;
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static const struct regmap_bus pmci_indirect_bus =3D {
> > +	.reg_write =3D pmci_indirect_bus_reg_write,
> > +	.reg_read =3D  pmci_indirect_bus_reg_read, };
> > +
> > +static const struct regmap_range m10bmc_pmci_regmap_range[] =3D {
> > +	regmap_reg_range(M10BMC_PMCI_SYS_BASE,
> M10BMC_PMCI_SYS_END), };
>=20
> If you have just one range, why bother defining it?

There is different register range between SPI bus and PMCI bus of BMC.
For SPI bus interface, the register  range of BMC is: 0x300800 - 0x300fff
For PMIC bus interface, the register range of BMC is: 0x0 - 0xfff

>=20
> > +
> > +static const struct regmap_access_table m10_access_table =3D {
> > +	.yes_ranges	=3D m10bmc_pmci_regmap_range,
> > +	.n_yes_ranges	=3D ARRAY_SIZE(m10bmc_pmci_regmap_range),
> > +};
> > +
> > +static struct regmap_config m10bmc_pmci_regmap_config =3D {
> > +	.reg_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +	.val_bits =3D 32,
> > +	.wr_table =3D &m10_access_table,
> > +	.rd_table =3D &m10_access_table,
> > +	.max_register =3D M10BMC_PMCI_SYS_END, };
>=20
> The same concern, these should be specific to BMC, not PMCI interface, is=
 it?

I think this is related to different regmap configuration for different bus=
 interface like SPI or PMCI, so
It should be in PMCI interface.

>=20
> > +
> > +static int pmci_probe(struct dfl_device *ddev) {
> > +	struct device *dev =3D &ddev->dev;
> > +	struct pmci_device *pmci;
> > +
> > +	pmci =3D devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > +	if (!pmci)
> > +		return -ENOMEM;
> > +
> > +	pmci->m10bmc.dev =3D dev;
> > +	pmci->dev =3D dev;
> > +	pmci->m10bmc.type =3D M10_N6000;
>=20
> The DFL feature only binds to N6000 BMC? Then the driver should be named =
dfl-
> n6000-bmc I think.

Yes, maybe M10_DFL should be better.

>=20
> > +
> > +	pmci->base =3D devm_ioremap_resource(dev, &ddev->mmio_res);
> > +	if (IS_ERR(pmci->base))
> > +		return PTR_ERR(pmci->base);
> > +
> > +	pmci->ctx.base =3D pmci->base + M10BMC_PMCI_INDIRECT_BASE;
> > +	pmci->ctx.sleep_us =3D INDIRECT_INT_US;
> > +	pmci->ctx.timeout_us =3D INDIRECT_TIMEOUT_US;
> > +	pmci->ctx.dev =3D dev;
> > +	pmci->m10bmc.regmap =3D
> > +		devm_regmap_init(dev,
> > +				 &pmci_indirect_bus,
> > +				 &pmci->ctx,
> > +				 &m10bmc_pmci_regmap_config);
> > +	if (IS_ERR(pmci->m10bmc.regmap))
> > +		return PTR_ERR(pmci->m10bmc.regmap);
> > +
> > +	return m10bmc_dev_init(&pmci->m10bmc); }
> > +
> > +#define FME_FEATURE_ID_PMCI_BMC	0x12
> > +
> > +static const struct dfl_device_id pmci_ids[] =3D {
> > +	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> > +
> > +static struct dfl_driver pmci_driver =3D {
> > +	.drv	=3D {
> > +		.name       =3D "dfl-pmci-bmc",
> > +		.dev_groups =3D m10bmc_dev_groups,
> > +	},
> > +	.id_table =3D pmci_ids,
> > +	.probe    =3D pmci_probe,
> > +};
> > +
> > +module_dfl_driver(pmci_driver);
> > +
> > +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> > +MODULE_AUTHOR("Intel Corporation"); MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index dd81ffdcf168..83c4d3993dcb 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -118,11 +118,19 @@
> >  /* Address of 4KB inverted bit vector containing staging area FLASH co=
unt */
> >  #define STAGING_FLASH_COUNT	0x17ffb000
> >
> > +#define M10BMC_PMCI_SYS_BASE 0x0
> > +#define M10BMC_PMCI_SYS_END  0xfff
> > +
> > +/* Telemetry registers */
> > +#define M10BMC_PMCI_TELEM_START		0x400
> > +#define M10BMC_PMCI_TELEM_END		0x78c
>=20
> The same concern, I asumme they are specific to BMC, not PMCI interface.

Yes,  I agree, I will remove it.

>=20
> Thanks,
> Yilun
>=20
> > +
> >  /* Supported MAX10 BMC types */
> >  enum m10bmc_type {
> >  	M10_N3000,
> >  	M10_D5005,
> >  	M10_N5010,
> > +	M10_N6000
> >  };
> >
> >  /**
> > --
> > 2.26.2
