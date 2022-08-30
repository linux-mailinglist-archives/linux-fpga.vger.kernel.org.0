Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0929E5A5F62
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiH3J0C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiH3J0B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 05:26:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D52A41D;
        Tue, 30 Aug 2022 02:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSvf/F95R9zRqSJgTaAVKRp7JoviS1OunLmNRDVOoDRmkjlBdgax/6WVA7XkF3L8GlRKOcUwUfoJB2KXhkodf0GpPFbQVSSVqjAB+FIWMX6lmU8xRRvDG90gtcaDrR1sVvGtQ1ymIqub26R+TW6tNOQhyaJ7v1mXE11VFuNrVFEj06rc2ToQtlGFs0S4HYBn4h5zIcjH/8AP4X8WIAQwSu9FgRsiGGdRQZaDN0ZRSpwTgfugHzGP75CHjGfJMkqT6jD/xClumTL1cNzAZn79a4sVh7ciADqFF8IGf1NXa7TSinq1JICZX4iHOcAnI1GJwQIFRNyYLkXSNhKZWzRdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moZYkUZPZ5+ldX4a4QjLeBTmDwlSrUjyqfioOk3eSRw=;
 b=Nk3k3N8MuMZONd+zPMFHvozTIEUeBwAqX1o/p6yf/7zH/5lKIl3rNvdBY9rcG0b+GpbIIO1Ng8tUiG0gRlMo9D2Wn91J067hmHOyIrUjuIunLnQ8A2gdixvLE8bGVIAFIE4OupgeDOan+Te/cwi/WUcSTKs40/9lCQiMsf4nTWN8wtLEnZEgRtITnB9ZKalltW0M1ktEh5FySfcx59PYT0FdbJtS9H4HSfc00gCIoC0WpuHhzjBWR1IF/PFMR6j+xvoJ7ghvi7/CIh/w0mF4FoDI7aYWhwst6yNrIT1yuVep+KAzCX703z7f1RVdAC8mUGWxtX+gfnem3Ssrtxp9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moZYkUZPZ5+ldX4a4QjLeBTmDwlSrUjyqfioOk3eSRw=;
 b=1CX8HEk0AZ6Ybwq5IUPlueOo+znttmRmRipIy4JTRT9NlIhZzPKaTzUV4sDcepoL1CLWAabfGj9HzQ5jwvj/mVA50j1pNvCsraQI6T1PrQhe1Xvq2d78FflEAecF57szwA6TCXaevayyM4+8HD0cYKR1Yv3TQ3WKTGxj31NNSg0=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 09:25:47 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:25:47 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
Thread-Topic: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
Thread-Index: AQHYt211lgmlMXglJ0SH5OSLecxmRa3CS7AAgAS5nUA=
Date:   Tue, 30 Aug 2022 09:25:47 +0000
Message-ID: <DM6PR12MB3993321B918B2124B6776320CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-2-nava.kishore.manne@amd.com>
 <Ywm39iYGLliU9ncv@yilunxu-OptiPlex-7050>
In-Reply-To: <Ywm39iYGLliU9ncv@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd231aa-ecd7-4e36-7058-08da8a699f71
x-ms-traffictypediagnostic: MN0PR12MB6221:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/8JyrJXmtvgmvuAy0/Ux203wnCxRhAYc6SOezSp1/hGuapC6/pCM1QBS9m5n1w7LTQiTQEcUuT9Sen5yWQjGfhclPtC64d/V0mIyZbRAU7nBpWJf5vMwnKC8P8RqZPWUtPVyk+/g3q76Hl/jthTnMacWsHAvgt+jptfo3Z0vwbA6KggGU7QbURZTmxlJ7uN2yqkTw+hDB5ULgSqvvLfl0Hhuj085yuTPQ5q0SkBqXWgQBpbVItApFDu6n018rGYX8YsioCAZFWnwMKaRdZwEAFC/gPdqv9zz/cD9Nhqs6BnCcbdSyxmvkxwWZXbZKBFk1eVp4L1hsJHfJKS9tOVXdUcG1bxH7h1ZaB/KsCjNEarBwgEf2uK1DL2PDnp8LNO218a0cp9xBMc5F8ZX5AG5dTQmJYm0Q2Rsnm+VCPUNKUoaNvfSUOsJxhf3TJABQRDgU6H0e40+0/QnBZw0Tlmx+DgL3GUA73G47H9T/YDXXv1bxjN+jTr2HullsNeHuCC8H6wbg48d0PMKhGlKGcBg9yWfHWlh2/FRqjbqRQpPj/mAUJPqxhhX+3NLphwmI/LNyIh6208XmjJDJSonS77XcKGndbzb6iVQ9Mv4Yx0HrNKVmGE4PHgFn0OQXz1R3WNxKqQslZJVZfAXgZgSk0T1WF/fneskI65wh3ok60+V27rk//yBfs1TDITlMfPGJgKlu6BdCvUOje7n5mSouekqHkQRt4UKk7XjtRwC+P6DUZURwnePHYjfD+vuNH9ohQK1ljEkBDm0aQ8uJisgxlHaY1Vo0vhkxzphDH/m3e3Be0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(7696005)(6506007)(122000001)(38100700002)(53546011)(2906002)(83380400001)(55016003)(26005)(33656002)(186003)(9686003)(86362001)(8676002)(966005)(4326008)(66946007)(71200400001)(66446008)(64756008)(76116006)(66556008)(66476007)(316002)(54906003)(6916009)(38070700005)(52536014)(8936002)(5660300002)(478600001)(41300700001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2OlDC/+3hDFhYUenlmNGNeHeWjWHmrZiVnuj5wcB+DFbwcRcQztH+JsAHde?=
 =?us-ascii?Q?CKx3Qr/xbeO58ESuv75Myde/DqgKDzatSV+1D0xk8EgVnyCLd9AwF3Vom26M?=
 =?us-ascii?Q?2mUzUqFhFc5FaBIntPpDxCPnTqnfOCkYPCv3vYdgkoNm1pBmWgu1VBOGZJRn?=
 =?us-ascii?Q?WENdNad7bk7wy9M5XGid2LJnscSfuKCL2WOJ/YlDwn/Y8ohCIJtLAqNKGY0B?=
 =?us-ascii?Q?W6NjA8frMZuNmvWv+vivdnZvvkmDjri/MjqPX+v8dJqrKIG3C/XCmfewVKpN?=
 =?us-ascii?Q?N8FiodFW5UYywT5K+mKiCfA2BzA7q5yXnRyD4fyzDXSajlvY/uaS/dKTZKMO?=
 =?us-ascii?Q?uxE40jr2j0tF/3q4U+kVs8yyCycX0IITwgVfEzIiv6g8bJ909raNaWILv4Ua?=
 =?us-ascii?Q?ms3lGRTP/tFjIfZTl3fTLt/Azbe/NDnLb1E7VXkelqjQMvgFj6TjAQNF/IXg?=
 =?us-ascii?Q?Pu3WQJg5X8z1ZJBR56fAUh5Y15YcDq9YcnAb+d6wt4/sN/usmHNGWT9LbciI?=
 =?us-ascii?Q?shVVxtBHnSDawJTEIX6TyWWS0vJkIFZO5Rg79QR/x2Z8fg/omtqUxF2BFsqe?=
 =?us-ascii?Q?KOubD01/kh/4QWZqq3YHBwjwEzGMlIeLZYpMMUnB3w+uJ1iRGrzDBNnOlzXI?=
 =?us-ascii?Q?zU/NmNyx1db9tEBisJt+JOlAimlBOmoLgsg6MoAw8ZB7ak4oxHd9CqGt1BUT?=
 =?us-ascii?Q?9Px6lnwb3l1lVCKznmKFkBOPoSu5qTQMEcGn5TwoLoklbWwo9wMBb4uYvqvr?=
 =?us-ascii?Q?gvrRXIZ+lSFP+Bk0QAmMxjJmoLdLlmMHCRloLspTJNRyg/vTq9g4ZQRML3KY?=
 =?us-ascii?Q?TqECrcXplu8k9xU/urQMy29tNV1oEZVCk2FFC3KDQGfOgGtCmyyAQ6n/dVMl?=
 =?us-ascii?Q?09QTXwBUfxZFfuvpNVTt6hpNypMhsV8Zok87K0j0/vEsZum2NyKc/QI9yvtv?=
 =?us-ascii?Q?2gHUFxVaNbtNyyTx9TchqjSMlnybj6vDd0gNgVU4YVkPocL8gBI4Y2Ct8YOs?=
 =?us-ascii?Q?kz96BjJhcnVwecNn9WM26k4P3++LEkWY9EN90c/Q8Ol8tTLKqEiw0E7IgjUQ?=
 =?us-ascii?Q?0I5axDFBAixB4RFaMdCX+ydjA8yUv/UtQifdqc917aSxNMDksVzWQtXVtgTs?=
 =?us-ascii?Q?Qw1uVVvr3AaO+HwXD8CkK8WUFRw6nB3N8g1juy+U/yC1sgTUFMO+oirxqHUD?=
 =?us-ascii?Q?5KEtgortdUOeX8pyF0o+zznK2gIA/sZhkYRcJ8WaRfTX4o6DOzN2FGSYlfbx?=
 =?us-ascii?Q?Fve3l9sk/BfbFB7Qm1ahkL3In+U+8hPn2Ylo1+BU4rgsrWMz7Ztkv+euSWM/?=
 =?us-ascii?Q?+aag5zf0TVFrtH+XCw1AIJn3llZI6/OMtiRgXM0i657rcqfZTTlNigMFtVJM?=
 =?us-ascii?Q?1N4se8XxorEai8V4g7c6EHmD1LsAxAucNzj81mon66+E1eYHShx0S3L84Sjw?=
 =?us-ascii?Q?7O79S/3RKsKbfI3V8Y9A2cYa6WIcfVksJy1CRQHIMw2pyrE0T9l5p200q23c?=
 =?us-ascii?Q?F6NQIQr0Cxxqb8tXjdErTs1LdgHMNAHPVBNqj4YTb8wf2e4qFsauq6MYff9y?=
 =?us-ascii?Q?wQKKqw5ROekfXgm1f/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd231aa-ecd7-4e36-7058-08da8a699f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 09:25:47.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gigH68pJXIuGi7fJe8AckvlI86EbT2xX6FxAOIsnVyGnQniVRN0dl0gfu9XAOw4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Please find my response inline.=20

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Saturday, August 27, 2022 11:52 AM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com;
> mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> p.zabel@pengutronix.de; gregkh@linuxfoundation.org;
> ronak.jain@xilinx.com; rajan.vaja@xilinx.com;
> abhyuday.godhasara@xilinx.com; piyush.mehta@xilinx.com;
> lakshmi.sai.krishna.potthuri@xilinx.com; harsha.harsha@xilinx.com;
> linus.walleij@linaro.org; nava.manne@xilinx.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org; yilun.xu@intel.com
> Subject: Re: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
>=20
> On 2022-08-24 at 09:25:39 +0530, Nava kishore Manne wrote:
> > Adds afi ioctl to support dynamic PS-PL bus width settings.
>=20
> Please also describe what is afi, PS, PL here, Patch #0 won't appear in
> upstream tree finally.
>=20

Agree, Will update the description in v2.

> Thanks,
> Yilun
>=20
> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 14 +++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 36
> > ++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index d1f652802181..cbd84c96a66a 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -843,6 +843,20 @@ int zynqmp_pm_read_pggs(u32 index, u32
> *value)  }
> > EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
> >
> > +/**
> > + * zynqmp_pm_afi() - PM API for setting the PS-PL bus width
> > + * @config_id:	Register index value
> > + * @bus_width:	Afi interface bus width value.
> > + *
> > + * Return:	Returns status, either success or error+reason
>=20
> I see other functions are also like this, but I still can't figure out wh=
at values
> for success and what for error+reason.
>=20

Please find the relevant error info here:
https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/firmware/xilinx/zy=
nqmp.c#L81

Regards,
Navakishore.

