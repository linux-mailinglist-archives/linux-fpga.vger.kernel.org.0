Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254559590E
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Aug 2022 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiHPKzL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Aug 2022 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiHPKyp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Aug 2022 06:54:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447CBBA4C;
        Tue, 16 Aug 2022 03:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnHdtv1A097j6cV5fA8P6wNSFJwg7Dqcd4CwejnbXu7tRVhc/PyT9d/HPGMKWmt18/gKrbjHDbTaJBD0FvA+68F+dWq5ARgLWYp3RdnjGvQ8gi8jbHqlU/5Ek24DMqLSEP2ZO5H3oMilqBnfDQacFe7WdYaXjJiAoW7Fd7IAA/cftqWZmte91Zm9Cat1PUZUzfh01DikjrSFf8RYsmOln8dPVPjtcR1ao5v1gp46v0ceccPC2+sZL0Kn6ddRaflByshi6dVPqdm1nG8yNqaDU3t21zqIQkK/Jq74Q5LIXbD6w/rtbLUgNDwscfxvKqm7TVhy1Slnti6oDyLW6T7vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM58bt5zyUpRbVY3U3QJ+25LMo+aUKc2n5BqZECMJZs=;
 b=Re4XY/R/fMbbIye5D8PUL0zY1MDXGf91O0iAZMC2zvK7X69WUlt1DNV70kkLrMN4fkv3otFvyXgJ8qNLUUzjCQHeR4x2gT7NYRWp6amVMbfYPFaSrFM/zj+8Sa0pFHAtcs+ZOzyhRoyHfT9Qt6gGF6Evl77W70ot+EK4wtyUbfkFeOi2XfLM+eE4k4EctmFSeqyk5TvPfh2vwzX4AEm4O49ebzqzu+9+LZTg5kDupjc8cHHAQSTzAxZApequD9bFwYM8dISgS6mPQwqNytMdv7ZcxH/l6oPgdEBE0fxegLgvwgnD0bzLEsC0iWx41bSmOSadZYj20sXvT3VSa+pqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM58bt5zyUpRbVY3U3QJ+25LMo+aUKc2n5BqZECMJZs=;
 b=I/OHOzJ8O+s5Pti497AHUd1OY0ya96yHhPHMfrAGPShVMqTNcdJOBdfmgtj3SPhAl+iKDqTsgdEjC5IAqqzM+W78WNP3k04QyqhFX8FYXqfWJpyGXvHcjZldCJOdYP3zDAmlwu1ocB/QGT8TkV4NwLuBmz6f5ZHBik9GZkkz1B0=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 10:22:28 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 10:22:28 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git@xilinx.com" <git@xilinx.com>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
  property
Thread-Topic: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
  property
Thread-Index: AQHYnNAAqZyFU+ID7UG/jL7udw2/r62xbBfA
Date:   Tue, 16 Aug 2022 10:22:28 +0000
Message-ID: <DM6PR12MB39935950EC1E2998075E0A1DCD6B9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
 <20220624162815.GA2142910@yilunxu-OptiPlex-7050>
 <DM6PR12MB39937A19AE147CD9105C8D52CD8C9@DM6PR12MB3993.namprd12.prod.outlook.com>
 <20220721065454.GA1689481@yilunxu-OptiPlex-7050>
In-Reply-To: <20220721065454.GA1689481@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb7f1b6f-fd74-4ea5-257a-08da7f7138bc
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdPXRjtaswcv5tgtIzvs9IsLn5B9l+NZJKLbSq7sO+X+4Km25hVqWVHJzUfyVIvCO+NOAPWlPuNUbkixWcnrFt6IoXYFPtdD9YdZwilkHKLPlUElXl0yAD7W2Zyy6WfPuPO7amKjJvq4zL+2OrRRkR1hPfWBT3p0T4D+xdY6VNawxnf3lykYdURYV2WMwCBmfq7LnoBAfkkJB2o3rEr2sz/MI4vNu87Xg8CmT31CzMhGxqwhhTqfyUJ+ZAyeUY1XrEQJ/Gm8BxxPmICLenbOnYakURB36+MimVxpBhaU7H+6Oyt4uX8VSS6GFI6BJLdm9Ig4GA/Sai2/u09M87xbCZ6YZqQEmR+0JF/4DnVi2Q5V/PbPuIOM6n0lJYYwszWhXdXRk6lqjuSMVqSnVktMU9ekt7uzbHqVB+ZCQIUL1WNtbMHPga4bdvyYqrCjpufN4KeZ9lygYEmUQxa86HabbnrHISXYXywROZPb25sPr/OTzdxb4ETrafI/KgV6sXLjeXuh8NWKXkosFcPOLvA2XqPrVgXi5mpYrWmGM76npoaEVK8Jw4aTLCwjRXeQz4G/vECUhPYigl8bR7yzf3gw9LoGP+b0AqccLJfAS5AqQLM3IMjDKFouLe1QKWRDOFuk2e8JYQ03OxNJXfj2EXbltoilqM02LwlmviaUuO93AEqrMxvLlExhSMUNJdy6XM/ArCPvmVkDqX5f60Zm/CEZifaQ3bTvU3kei21onOPGDMz6x8y2pvaO0uR7yRXR+BHJIZhO1AH8dlc7UGJX4l7oxSonHk1u8fBouia+Zg+BA7KrTdF1/RZHfSC8KP+c8eac
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(71200400001)(54906003)(53546011)(9686003)(7696005)(6506007)(86362001)(55016003)(186003)(26005)(83380400001)(6916009)(316002)(76116006)(4326008)(41300700001)(66946007)(66476007)(33656002)(66556008)(66446008)(2906002)(478600001)(5660300002)(52536014)(8676002)(38070700005)(7416002)(122000001)(8936002)(64756008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+lNM5JZ1vOftHPsCxc9/w3E9MJIWLa/TiK9wkPEQ918LhaHRzsGc/eivhGmn?=
 =?us-ascii?Q?fnhJehGQXFIWl/I9ZjIqM3Sh33ELcqOtZKi6n1R7vlQ7aUI1fIJsu3lXgqQx?=
 =?us-ascii?Q?T9eCDNadSIdgbllqcmM/j0yStT4Q0lhtknLeiSyXLzKljdnIYmYc0gjDA2bc?=
 =?us-ascii?Q?clMng5187MKLCcpKGb719XiCb9qI+REFhBvYRT8N7OSH2erMCU3jUmB7o4TM?=
 =?us-ascii?Q?6Hnm0EOm4cvU0CJhg00Cl8QLNuCJtrz3D9SLM9O202JrbkVh4Dm5ezlBKowu?=
 =?us-ascii?Q?E+rVoPD+kPQwBuF3RCNXJf0wmvPeZF2/vgY3HcjDvbXmta/tD2EGU25SIy5P?=
 =?us-ascii?Q?Jt8912mafr+CLmv5gnqFONc+tGqx9w5wkNOfvzQTtJ95y7oSfTlKEQHyQ6yw?=
 =?us-ascii?Q?qnicl1OoLdJMBiL2MaUJCI9blrAOcrMQiX2ORVoz7kOXeg01i2kLtWami/3O?=
 =?us-ascii?Q?kqyUFBMsUvaiyczDr6Sa3XpFaoaRqvpO40wfxPj7gfnalXw9cs/tr5UcE7ak?=
 =?us-ascii?Q?PoqocdkOIrVaR+l3Xy8gLoY/+8Qq1HFJEyjHuhYnNDE5prP8hoiaO7a/rnDb?=
 =?us-ascii?Q?yM5B4h0l5leAAcwX/zX6XTkHdRIMhXAHDNR/XDzt/faMI7aVsN4k/O5lkBVQ?=
 =?us-ascii?Q?PA17FO1nOXRrf0Esf21sGfGyl6HMNYPe0n4BVa8Firsv+Ia0KZs6oJ/SOez1?=
 =?us-ascii?Q?bFMy4dqQb85OheVePo2wFy5DPR9ZTpOlHvS6KERYXV9Src/YnlgMiVrv4LX1?=
 =?us-ascii?Q?6do09/AxItrfclMSLa0nqW15A6nwsfNoPKHf5M5JDPA8Bs8R/Yq1ri2n9q/j?=
 =?us-ascii?Q?KTWKfYifRvu+2B8FFrCx0JOuuUKrucjJVyj75nCxx9mTT3vrjU73zsb9bxCa?=
 =?us-ascii?Q?JjXXKdlyEpbpphobydqmQ0DsjcIopNJko4C7MJp4zpBAbim6l5jIPrxOu6Qb?=
 =?us-ascii?Q?dZYwgjF/xtM/kiakdjOvuGtJ5BScyDvTfSecQ03rDexyAtesNexmkw/Yh0UD?=
 =?us-ascii?Q?JA+DbAoLDhmrR7XpiWqUCYZXM/sAlkGztSqq8N6X2tNLTHxMrcU9ViQnB/rG?=
 =?us-ascii?Q?mH24Np9Xb0vMcdexSyrkixVBCdUzNcgPA4mcGTXzdCDqJGjnhpd4lMU5LmP5?=
 =?us-ascii?Q?e826Yk3LPoBP+YfwP3/wyzUfWM4Ly4y21N7SOURZz1U9pHkmvXhSycsi/XK+?=
 =?us-ascii?Q?NWMn6mtR3jrbgT2qzkbZJfVVGuM1imR82Z6plvAAdpTBiviiwLYTUVwdLMVn?=
 =?us-ascii?Q?2MJazLAcHNNRZxKlf43/6FJI0FZSxxua50fFO5vks9yhwjyxP3opnUyXxiKn?=
 =?us-ascii?Q?EEtWXEkZCaPXYJfMJ//qWOXmqfG0QMmxWb1k4vw2vaPjzR9WKPif+Q8RDPUn?=
 =?us-ascii?Q?c2qC2YpwLa8M2mjfB5A5+ZLPWHeZsFNbsd0yX4s8HvRXk1qNQh6XVxy1e5UK?=
 =?us-ascii?Q?rIFeH2mCMK910jjzdlfFnzwPZFcfQh+uUsb1jAIGEqvY0m7IZyqYAS3FI+2o?=
 =?us-ascii?Q?FijlBRCDJU7Tipgq7H/JyKv9nwp9rqv6OGfeeBK8H+E8MOHJIwZeZSvb6Yh6?=
 =?us-ascii?Q?FCHUjnK4YeHRz2uSDVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7f1b6f-fd74-4ea5-257a-08da7f7138bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 10:22:28.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1tsjRILtoZFgV4VAiOSg6iBBf45R0/SU29bIWNiUFpD90r3vSlqcjXomJHI93bW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
> Sent: Thursday, July 21, 2022 12:25 PM
> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Cc: Nava kishore Manne <nava.manne@xilinx.com>; mdf@kernel.org;
> hao.wu@intel.com; trix@redhat.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> git@xilinx.com; Rob Herring <robh@kernel.org>
> Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
> property
>=20
> On Mon, Jul 18, 2022 at 06:46:32AM +0000, Manne, Nava kishore wrote:
> > Hi Yilun,
> >
> > 	Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > Sent: Friday, June 24, 2022 9:58 PM
> > > To: Nava kishore Manne <nava.manne@xilinx.com>
> > > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com;
> > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > michal.simek@xilinx.com; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; git@xilinx.com; Rob Herring
> > > <robh@kernel.org>
> > > Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-
> domains'
> > > property
> > >
> > > CAUTION: This message has originated from an External Source. Please
> > > use proper judgment and caution when opening attachments, clicking
> > > links, or responding to this email.
> > >
> > >
> > > On Mon, May 23, 2022 at 07:15:16PM +0530, Nava kishore Manne wrote:
> > > > Add fpga-region 'power-domains' property to allow to handle the
> > > > FPGA/PL power domains.
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > Changes for v2:
> > > >               - Updated power-domains description.
> > > >
> > > >  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++=
++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > index 7d3515264838..f299c3749505 100644
> > > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > > @@ -196,6 +196,20 @@ Optional properties:
> > > >  - config-complete-timeout-us : The maximum time in microseconds
> > > > time
> > > for the
> > > >       FPGA to go to operating mode after the region has been
> programmed.
> > > >  - child nodes : devices in the FPGA after programming.
> > > > +- power-domains : A phandle and power domain specifier pair to
> > > > +the
> > > power domain
> > > > +     which is responsible for turning on/off the power to the
> > > > + FPGA/PL
> > > region.
> > >
> > > Could you help explain what is PL?
> > >
> > > > +Example:
> > > > +     fpga_full: fpga-full {
> > > > +                compatible =3D "fpga-region";
> > > > +                fpga-mgr =3D <&zynqmp_pcap>;
> > > > +                #address-cells =3D <2>;
> > > > +                #size-cells =3D <2>;
> > > > +                ranges;
> > > > +                power-domains =3D <&zynqmp_firmware PL_PD>;
> > > > +        };
> > > > +
> > > > +     The PL_PD power domain will be turned on before loading the
> > > > +bitstream and turned off while removing/unloading the bitstream
> > > > +using
> > > overlays.
> > >
> > > I think the single power-domain may not cover some use cases that
> > > of-fpga- region driver supports.
> >
> > I am not sure which use case you are talking about. Can you please poin=
t
> me the exact use case here?
> >
> > > It is possible there are already devices in fpga-region for static
> > > OF tree, or an overlay with no 'firmware-name' but 'external-fpga-
> > > config'. In these cases power domains may still be needed, is it?
> > >
> >
> > It's an optional property user can decide whether he needs this
> > support or not for 'external-fpga-config Use case.
>=20
> If an external-fpga-config FPGA region needs to enable a power domain
> before sub devices population, how could it config the DT? I assume in th=
is
> patch "power-domains" property is only used before & after reconfiguratio=
n
> but external-fpga-config FPGA region may need no reconfiguration.
>=20
I agree, For 'external-fpga-config' use case this patch is not capable of s=
upporting the dynamic PM.
I Will explore and get back to you to handle this use case.

> >
> > > Another case is the fpga-region may need multiple power domains?
> > >
> >
> > In our use case full region and relevant partial regions have
> > different power domains and this patch is capable of handle different
> > power domain regions (full and partial regions)
>=20
> If a FPGA region needs 2 or more power domains for partial reconfiguratio=
n,
> how could we find out and enable them all?
>=20
> From the 2 cases, I see as a generic driver, there may be need to enable
> different power domains at different moments. And I'm afraid a simple
> implementation of pm_runtime_get before reconfiguration may limit the
> usage of "power-domains" property for of-fpga-region.
>=20

Can you please point me any references to handle the multiple power domains=
?

This implementation is region specific which means it can handle both full =
and partial power domains
Independently based on the power domains info exists in the DT.
For example:

Base DT: For full
fpga_full: fpga-full {
                compatible =3D "fpga-region";
                fpga-mgr =3D <&zynqmp_pcap>;
                #address-cells =3D <2>;
                #size-cells =3D <2>;
                ranges;
                power-domains =3D <&zynqmp_firmware PL_PD>;
};

Overlay DT: For Partial
fragment@0 {
	target =3D <&fpga_full>;
	#address-cells =3D <2>;
	#size-cells =3D <2>;
	 __overlay__ {
		#address-cells =3D <2>;
		#size-cells =3D <2>;
		firmware-name =3D "full.bin";
		fpga_PR0: fpga-PR0 {
			compatible =3D "fpga-region";
			#address-cells =3D <2>;
			#size-cells =3D <2>;
			ranges;
			power-domains =3D <&zynqmp_firmware PL_PR_PD>;
		};
	 };
};

Regards,
Navakishore.
