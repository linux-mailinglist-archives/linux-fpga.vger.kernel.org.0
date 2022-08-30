Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AE5A5F3D
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiH3JUi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiH3JUQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 05:20:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E2192BC;
        Tue, 30 Aug 2022 02:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar5PAn/B0dZFtLOPHSwx6vEj2wu7qU61Hja1TMmLQERWTMFHhAuYoiq+3KSwpq0F1vmlFGpL20zqDcHYEI//DUomGr587uA1eTR7Mhac2tyErdKKZSMhfY30Jg8w/BWO58Za3ChexEldeB/56HVNDNkjJj1QcJitFV9wB/uk9G0PIk86bery/F6B0z6PYdaCo3r4WEkY5OLxAOnbfTv8Z9mz5FlCQxfnELrsRF430fd3GjHLLhVdYG7wCfXKPCz4w/V+DFDjTnU7id6btrU93pXLRHkUjsdfhREcI22dd7wse47WTdT2wHoxDRbx7Pc4nRDkqNIFaIlBBAx6qN+X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBPDr0RVd581A6IivwnEDTeg9CxVpLDU/wNPmsNjua4=;
 b=BO3O2jfrqS28FEbMS/4HZGtCxMw/1qkPom2U56nT+izLUp47rWp6FdopNcHPBIxnxV33PfGf79J/vT9CsK3b6WHAzoK5higS39/tdmK7IqyzfAIDXzw3q5XQs+I3UA8lMify49BDMSO8ILXr1GfFzGOGym9UlWfGLIdn2MPvMk4D8bwMfpoWAC1Yde0+U+/zK6gE2RtMJ1cJSzRBbhFdWeECh5tARPi+vjme6d42iUDSQD7W0W7Wfs0f4V2K8XEQmQPye+NAL0Ab0oPVV40a5DA006TfFVWfWCFlIaqD+0LeQwcS1zp9lvDuI4cKOWwrEsD6KkXeqbBBuXNnaKFdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBPDr0RVd581A6IivwnEDTeg9CxVpLDU/wNPmsNjua4=;
 b=3nsaqs0PqAfW+I8fYbGX2zEikanxlXJMMC5fq9iZwZLHjsgcX3/b+nePBzyb1zx2dac4zkKIO1OYruX7sSOhEOu5lcrPASPA8Kt85sSjF+YJpipQ+15MWHMqTBOftD83TmkFMND0vwkN8MHAqKl8MRjnlsBx3b2a0LR1lcFJrrQ=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 09:19:52 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:19:52 +0000
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
Subject: RE: [PATCH 4/4] fpga: zynqmp: Add afi config driver
Thread-Topic: [PATCH 4/4] fpga: zynqmp: Add afi config driver
Thread-Index: AQHYt2186EV3Elj4oU2H7JOnZ5bSfa3CsZyAgARkCbA=
Date:   Tue, 30 Aug 2022 09:19:52 +0000
Message-ID: <DM6PR12MB39932285FD0EC72F1F04D8E8CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-5-nava.kishore.manne@amd.com>
 <YwoNdUPoSKKHhzxx@yilunxu-OptiPlex-7050>
In-Reply-To: <YwoNdUPoSKKHhzxx@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a446da7c-2fa5-4b8f-55fe-08da8a68cbaf
x-ms-traffictypediagnostic: CH2PR12MB3976:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaNYp9X0axWkA+Kquo0HnQTeL5iFdDxqj8t0neamfe7oexeLczR70cTVE7aVo4hkTHgH2+vQm8J7GXy/UIF71BSc+jmYH6XIUz5VYvXrtwR+Yu5gh134v/uxSb7L/O/qTxaTfKHWkTZRrrHLIHHk03+1tLy+JbfBSJkTaMacuptYAr3gHmqvruv0X2gEpTVI3B2SOd93QxZ+9izyPml1UfJ89pvQ+JNR2hhkh6xsx249QqZ3oLSHeey28pA2XiGyANbOQQK7TbsgtoUYxL/QJ+4AVYKvdo0NBSRIPYSKAgtXGXg0mzMFvvWgsdveUZU/cSweiWiHYalQFOKyooANYBQzOvdKI501nJPmlftevxs001y2IAdCa9p44n5ReEN0WIEpCbJJp8vqWelV5ErzExhRqaMY1Xl5N1GwpVd2vOzF2VDpyhd2tzB6Ljpl1HqAK93tktiFS1gcyJkB55A4FQnzWx7dkpstIE0BSPFZXdeIyBSxDsXThOIv0mWye3qntwLzGbAXF1eCXwJrKWZI0yFTo20WgsspT2DCivz1C6lkrCwS9HLgK6z2Dn86KGVu/a8rBTaibaHuIPvNPkGDsgH94rsylL/+eZcfvc2W7mA2LXcqau45Qt1N5TCx+lCdiyK4jy20/3nONsQHMDLPL6BRLvqhTjsTaM/0btDF/b0lJgdT4TUhaHkD3kbKu5gbh4WnqldkAPv+bEKbxG4qB3t5bRZvDHSQzxfdR4+RQ5FYcCnbk/pRnvCNJ6TAz5AZbmQwOAes0qZ3XqZZsNMv+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(38100700002)(6506007)(122000001)(7696005)(2906002)(30864003)(55016003)(83380400001)(33656002)(186003)(9686003)(26005)(53546011)(86362001)(8676002)(4326008)(66946007)(71200400001)(66446008)(64756008)(76116006)(66556008)(66476007)(54906003)(6916009)(52536014)(478600001)(316002)(38070700005)(8936002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zjjG7I8DCJe5VmsjJYHaDGQBEPLmKAOqmOALiCT9zG6XtQYd+pOxDSiUeljN?=
 =?us-ascii?Q?KS3TuiBlgNS2TlwcSlU30AN6xO4PXpU3qlxuvWsVWknWm/cZpS46xhNAUagZ?=
 =?us-ascii?Q?1ZxqXKaLNn0swkn46Vh8hf0n2L5zp4d2rUohya+mKCkkIE0yWCqbhGatuoh7?=
 =?us-ascii?Q?XGYTjTUXHcltQR48j7Vk/mssipidnE4vD4ceerb2nrzz1BtA6lNl+1GUtd41?=
 =?us-ascii?Q?5XyD1YCBtV/Mkc/NF2yRd1lz/rmcZH5PaZtVmgTNTG0zVSDdT95Jj5lVkdPI?=
 =?us-ascii?Q?ygWZqzfAXRz7gKg3U9IMiPuH5UXM5kU6rweSis7xSt0QHFtb4Lq7tCvDvRhU?=
 =?us-ascii?Q?Y1egoOb8PmtRAprzwphyX7/+Zy4bG9VnKupRWu5InxXJVCdPbZdTgT2sG6t3?=
 =?us-ascii?Q?jyrMpnGtuevz6K5lzF73iFYWqLNR+DvGtBuqqu3alDlEFe9BiUk2nSjER32d?=
 =?us-ascii?Q?Vfmesz30rWMtw046ZFeoe2g8k7cOx5yvyZPcNTF72pIlHR1nnn3CJ+cfoGbH?=
 =?us-ascii?Q?CrsLKUzYl1VOPKSzTgtOl268lmhMn1TSvyhmrz7T4NLYt6SBx/BxZAgy8RcN?=
 =?us-ascii?Q?D/l5FEbrefIJzAMSD2bzU7U1warvFW303CnX6pAlGH5bxOZvkTdAFcjjD/Dh?=
 =?us-ascii?Q?oYRAmx2+mAdmJgojddtd75p93XZWtUMYUi/HQbl1GKzdsUBCxXUjUel5Y95I?=
 =?us-ascii?Q?o70ePhM1EgxvzdUGbQuuza6m7z45Q85zVdppzd7q38B/DlJz6xOrcYrkLmrF?=
 =?us-ascii?Q?byIg88NkF70J1IeR63hrubYpOgIHNvJWqa8U91ULEIDCgBDIHFJT92M2ihcx?=
 =?us-ascii?Q?PUtAT+xBWkebFEPPjVDe5hQZ/I2333nBDwHcvDIMd8JzszjpZlFSpOuyIAoO?=
 =?us-ascii?Q?EhZ/otdwRAQSMrcx0ze709TCGqmOu07Walvu8x4nMVtf5fVF81EsUtZ5DkpW?=
 =?us-ascii?Q?QNcWDbJMLQETj8ITzBVCIeTvu6j6DByw8JjXM2qr3JcBYs9oFcTcXYPXEyb1?=
 =?us-ascii?Q?mErmkMCn9WKMB5yURFSBkFrT7ggmMxkNmPc1pVM8SPzfiDMsZphR35ZlCGM+?=
 =?us-ascii?Q?/FcPmlfPrMvtQEqyQwSxMR/EpzIy39rRL5Rg0GJrN8R75DXvmmlBFQlfmb4W?=
 =?us-ascii?Q?eMgYgacH6rWswlcIZ+ORG8bG6OW2yUeU2/mpY/6VqW7FMlzrFKt/R50gSaD2?=
 =?us-ascii?Q?gzwX36597UXRKB963Qfj6JLTHiv5fhjPOtXaE5H+mkcJ2LAM38yz87X/VU6S?=
 =?us-ascii?Q?uqj78MZuiTUi+eS0T2IK0f3yf4lsvhtB1sv0ZqMDcBGpMhK7fq+xF286Uz1i?=
 =?us-ascii?Q?MkmYqmSviHg8XdeyeGt7yMYYRSxuwRIHFLOBsccQFatCFVSTpsoLHHVqZtDT?=
 =?us-ascii?Q?BIcVBXgE4fN0+iRKW+zIYM+Zo7GkXnca9gNEUod2iuVibW3JAF7cSr+5mTQg?=
 =?us-ascii?Q?w/ZwWururroEG5ByQegaEGQCKVrBUjOB3rc8SOhHc5PQygKc3GsJOtE20bK6?=
 =?us-ascii?Q?q0rS+snZrkgn8b0jIooKkeY1m6l/nJHku6YVg27vzTva2uc6GvVZeB8yC+Zh?=
 =?us-ascii?Q?aM3iRsfCwX1y8Dcnrf4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a446da7c-2fa5-4b8f-55fe-08da8a68cbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 09:19:52.4687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkxYqF4g61jdOcpf4dqzAu1zybRDVP78bYYQl57mT1sqWnHvOkeS0WHTRut5hxq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Saturday, August 27, 2022 5:56 PM
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
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On 2022-08-24 at 09:25:42 +0530, Nava kishore Manne wrote:
> > Add zynqmp AXI FIFO interface(AFI) config driver. This is useful for
> > the configuration of the PS-PL interface on Zynq US+ MPSoC platform.
>=20
> Please help illustrate how to use the device for FPGA reprogramming, why =
it
> should be implemented as an FPGA bridge.
>=20
> From the code I actually didn't see any operation that gates the fpga-reg=
ion
> from other part of the machine.
>=20

The Zynq UltraScale MPSoC family consists of a system-on-chip (SoC) style i=
ntegrated processing system (PS)
and a Programmable Logic (PL) unit, providing an extensible and flexible So=
C solution on a single die.=20
Xilinx Zynq US+ MPSoC connect the PS to the programmable logic (PL) through=
 the AXI port.=20
This AXI port helps to establish the data path between the PS and PL (Here =
AXI Interface act as a Gating between PS and PL)
and this AXI port configuration vary from design to design.  In-order to es=
tablish the proper communication path between
PS and PL (Full region),  the AXI port data path should be configured with =
proper values priories to load the full region.

Will update the description in v2.

> >
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> >  MAINTAINERS               |   6 ++
> >  drivers/fpga/Kconfig      |  13 +++
> >  drivers/fpga/Makefile     |   1 +
> >  drivers/fpga/zynqmp-afi.c | 211
> > ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 231 insertions(+)
> >  create mode 100644 drivers/fpga/zynqmp-afi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 20ffac651214..957e753e6406 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8032,6 +8032,12 @@ F:     Documentation/fpga/
> >  F:   drivers/fpga/
> >  F:   include/linux/fpga/
> >
> > +FPGA ZYNQMP PS-PL BRIDGE DRIVER
> > +M:   Nava kishore Manne <nava.kishore.manne@amd.com>
> > +S:   Supported
> > +F:   Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
> > +F:   drivers/fpga/zynqmp-afi.c
> > +
> >  INTEL MAX10 BMC SECURE UPDATES
> >  M:   Russ Weight <russell.h.weight@intel.com>
> >  L:   linux-fpga@vger.kernel.org
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 6c416955da53..c08794d30fb5 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -130,6 +130,19 @@ config XILINX_PR_DECOUPLER
> >         reconfiguration, preventing the system deadlock that can
> >         occur if AXI transactions are interrupted by DFX.
> >
> > +config ZYNQMP_AFI
> > +     tristate "Xilinx ZYNQMP AFI support"
> > +     depends on FPGA_BRIDGE
> > +     help
> > +       Say Y to enable drivers to handle the PS-PL clocks configuratio=
ns
> > +       and PS-PL Bus-width. Xilinx Zynq US+ MPSoC connect the PS to th=
e
> > +       programmable logic (PL) through the AXI port. This AXI port hel=
ps
> > +       to establish the data path between the PS and PL.
> > +       In-order to establish the proper communication path between PS =
and
> PL,
> > +       the AXI port data path should be configured with the proper Bus=
-
> width
> > +       values and it will also handles the PS-PL reset signals to rese=
t the
> > +       PL domain.
>=20
> Same concern, please describe its relationship to FPGA reprogramming.
>=20

Same as above.
Will update the description in v2.

> > +
> >  config FPGA_REGION
> >       tristate "FPGA Region"
> >       depends on FPGA_BRIDGE
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > 42ae8b58abce..94cfe60972db 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -31,6 +31,7 @@ obj-$(CONFIG_FPGA_BRIDGE)           +=3D fpga-bridge.=
o
> >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)    +=3D altera-hps2fpga.o altera-
> fpga2sdram.o
> >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)   +=3D altera-freeze-bridge.o
> >  obj-$(CONFIG_XILINX_PR_DECOUPLER)    +=3D xilinx-pr-decoupler.o
> > +obj-$(CONFIG_ZYNQMP_AFI)             +=3D zynqmp-afi.o
> >
> >  # High Level Interfaces
> >  obj-$(CONFIG_FPGA_REGION)            +=3D fpga-region.o
> > diff --git a/drivers/fpga/zynqmp-afi.c b/drivers/fpga/zynqmp-afi.c new
> > file mode 100644 index 000000000000..bc975d304039
> > --- /dev/null
> > +++ b/drivers/fpga/zynqmp-afi.c
> > @@ -0,0 +1,211 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Xilinx, Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/firmware/xlnx-zynqmp.h> #include
> > +<linux/fpga/fpga-bridge.h> #include <linux/io.h> #include
> > +<linux/module.h> #include <linux/of.h> #include
> > +<linux/platform_device.h> #include <linux/reset.h> #include
> > +<linux/slab.h>
> > +
> > +/* Registers and special values for doing register-based operations */
> > +#define AFI_RDCHAN_CTRL_OFFSET       0x00
> > +#define AFI_WRCHAN_CTRL_OFFSET       0x14
> > +#define AFI_BUSWIDTH_MASK    BIT(0)
> > +
> > +/**
> > + * struct zynqmp_afi - AFI register description.
> > + * @dev: device that owns this.
> > + * @of_node: Device Tree overlay.
> > + * @resets: Pointer to the reset control for ps-pl resets.
> > + */
> > +struct zynqmp_afi {
> > +     struct device *dev;
> > +     struct device_node *of_node;
> > +     struct reset_control *resets;
> > +};
> > +
> > +/**
> > + * struct zynqmp_afi_configreg - AFI configuration registers info.
> > + * @reg:     Name of the AFI configuration register.
> > + * @id:              Register index value.
> > + */
> > +struct zynqmp_afi_configreg {
> > +     char *reg;
> > +     u32 id;
> > +};
> > +
> > +static struct zynqmp_afi_configreg afi_cfgreg[] =3D {
> > +     {.reg =3D "xlnx,afi-fm0-rd-bus-width",    .id =3D AFIFM0_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm1-rd-bus-width",    .id =3D AFIFM1_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm2-rd-bus-width",    .id =3D AFIFM2_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm3-rd-bus-width",    .id =3D AFIFM3_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm4-rd-bus-width",    .id =3D AFIFM4_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm5-rd-bus-width",    .id =3D AFIFM5_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm6-rd-bus-width",    .id =3D AFIFM6_RDCTRL},
> > +     {.reg =3D "xlnx,afi-fm0-wr-bus-width",    .id =3D AFIFM0_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm1-wr-bus-width",    .id =3D AFIFM1_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm2-wr-bus-width",    .id =3D AFIFM2_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm3-wr-bus-width",    .id =3D AFIFM3_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm4-wr-bus-width",    .id =3D AFIFM4_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm5-wr-bus-width",    .id =3D AFIFM5_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fm6-wr-bus-width",    .id =3D AFIFM6_WRCTRL},
> > +     {.reg =3D "xlnx,afi-fs-ss0-bus-width",    .id =3D AFIFS},
> > +     {.reg =3D "xlnx,afi-fs-ss2-bus-width",    .id =3D AFIFS_SS2},
> > +     {}
> > +};
> > +
> > +static int zynqmp_afi_config(struct zynqmp_afi *afi_data) {
> > +     struct zynqmp_afi_configreg *cfgptr =3D afi_cfgreg;
> > +     struct device_node *np =3D afi_data->of_node;
> > +     u32 afi_ss0_val, afi_ss1_val, bus_width;
> > +     int ret;
> > +
> > +     while (cfgptr->reg) {
> > +             ret =3D of_property_read_u32(np, cfgptr->reg, &bus_width)=
;
> > +             if (!ret) {
> > +                     if (cfgptr->id =3D=3D AFIFS_SS2) {
> > +                             if (bus_width =3D=3D 32)
> > +                                     ret =3D zynqmp_pm_afi(AFIFS_SS2,
> > +                                                         AFIFS_SS_BUS_=
WIDTH_32_CONFIG_VAL);
> > +                             else if (bus_width =3D=3D 64)
> > +                                     ret =3D zynqmp_pm_afi(AFIFS_SS2,
> > +
> AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL);
> > +                             else if (bus_width =3D=3D 128)
> > +                                     ret =3D zynqmp_pm_afi(AFIFS_SS2,
> > +
> AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL);
> > +                             else
> > +                                     return -EINVAL;
> > +                     } else if (cfgptr->id =3D=3D AFIFS) {
> > +                             if (bus_width =3D=3D 32)
> > +                                     afi_ss0_val =3D AFIFS_SS_BUS_WIDT=
H_32_CONFIG_VAL;
> > +                             else if (bus_width =3D=3D 64)
> > +                                     afi_ss0_val =3D
> AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL;
> > +                             else if (bus_width =3D=3D 128)
> > +                                     afi_ss0_val =3D
> AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL;
> > +                             else
> > +                                     return -EINVAL;
> > +
> > +                             ret =3D of_property_read_u32(np, "xlnx,af=
i-fs-ss1-bus-
> width",
> > +                                                        &bus_width);
> > +                             if (!ret) {
> > +                                     if (bus_width =3D=3D 32)
> > +                                             afi_ss1_val =3D
> AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
> > +                                     else if (bus_width =3D=3D 64)
> > +                                             afi_ss1_val =3D
> AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL;
> > +                                     else if (bus_width =3D=3D 128)
> > +                                             afi_ss1_val =3D
> AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL;
> > +                                     else
> > +                                             return -EINVAL;
> > +
> > +                                     ret =3D zynqmp_pm_afi(AFIFS, afi_=
ss1_val |
> afi_ss0_val);
> > +                             }
> > +                     } else {
> > +                             if (bus_width =3D=3D 32)
> > +                                     ret =3D zynqmp_pm_afi(cfgptr->id,
> > +                                                         AFIFM_BUS_WID=
TH_32_CONFIG_VAL);
> > +                             else if (bus_width =3D=3D 64)
> > +                                     ret =3D zynqmp_pm_afi(cfgptr->id,
> > +                                                         AFIFM_BUS_WID=
TH_64_CONFIG_VAL);
> > +                             else if (bus_width =3D=3D 128)
> > +                                     ret =3D zynqmp_pm_afi(cfgptr->id,
> > +                                                         AFIFM_BUS_WID=
TH_128_CONFIG_VAL);
> > +                             else
> > +                                     return -EINVAL;
> > +                     }
> > +             }
> > +             cfgptr++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int zynqmp_afi_enable_set(struct fpga_bridge *bridge, bool
> > +enable) {
> > +     struct device_node *overlay =3D bridge->info->overlay;
> > +     struct zynqmp_afi *priv =3D bridge->priv;
> > +     int ret =3D 0;
> > +
> > +     if (enable) {
> > +             reset_control_reset(priv->resets);
> > +             return 0;
> > +     }
> > +
> > +     of_node_get(overlay);
> > +     priv->of_node =3D
> > +     of_find_node_with_property(overlay,
> > +                                "xlnx,afi-fm0-rd-bus-width");
>=20
> I'm a little confused here. The fpga_image_info.overlay is for fpga-regio=
n, but
> from your binding doc this property is for this afi device. You want to a=
dd
> another overlay targeting afi dev node during reprograming?
>=20

Yes, it uses Overlay's(overlay targeting afi dev node). As I said above for=
 design-to-design AFI configs
relevant to the full region may change and these configs must be set prior =
to program the full region
once this overlay integrated to the live tree the existing afi config value=
s will be replace with the new one's

> > +     if (priv->of_node)
> > +             ret =3D zynqmp_afi_config(priv);
> > +     of_node_put(priv->of_node);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct fpga_bridge_ops zynqmp_afi_br_ops =3D {
> > +     .enable_set =3D zynqmp_afi_enable_set, };
> > +
> > +static const struct of_device_id zynqmp_afi_of_match[] =3D {
> > +     { .compatible =3D  "xlnx,zynqmp-afi-fpga" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, zynqmp_afi_of_match);
> > +
> > +static int zynqmp_afi_probe(struct platform_device *pdev) {
> > +     struct device *dev =3D &pdev->dev;
> > +     struct zynqmp_afi *priv;
> > +     struct fpga_bridge *br;
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->dev =3D dev;
> > +
> > +     priv->resets =3D
> devm_reset_control_array_get_optional_exclusive(&pdev->dev);
> > +     if (IS_ERR(priv->resets))
> > +             return PTR_ERR(priv->resets);
> > +
> > +     br =3D fpga_bridge_register(dev, "Xilinx ZynqMP AFI",
> > +                               &zynqmp_afi_br_ops, priv);
> > +     if (IS_ERR(br)) {
> > +             dev_err(dev, "unable to register Xilinx ZynqMP AFI");
>=20
> Need a "\n" at the end?
>=20

Will fix.

Regards,
Navakishore.

