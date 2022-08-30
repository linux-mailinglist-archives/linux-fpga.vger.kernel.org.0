Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365B5A5B75
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiH3GFp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiH3GFk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 02:05:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C9719AB;
        Mon, 29 Aug 2022 23:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3DJ6tMu6QXziKn+MMW5sf8yqI2VmXgzbN0y9Qofw+Qtq3hVJO6sE/sq3xcxRwwaYP4+eb5BSjn0y7rgy2ffsXFBiTWV2VzKpEEBt2eTOtXKr69pPMewuPmR+jIK7GCMK7hqSvgf2ZwcVhsG2p2dFUNs1x3uMnc9qgc5BWPDpMiupL8wWGc4SCvnc6TiZaITMEBaGz1seAkAArHiKUCAJGR9yDvgGp4slVs14UfyHO83oHJOgJovR4osjM0LixuCCnoRtXwyTD2U/0fawGwTqtIjJ+yTAPpHPw7v2GRSmd8MPy98NkCEQFb/btlKqXsFtCZHAsHy68AejnJmrOQ38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDeUvabnCePhZ+hBtNeMXWa9Iod2XSLJUOMNIgEtylg=;
 b=bi95pbL5xgmx/5fqgD0A4OlPBwpWSx+xSnlh/+sQYMGSZ4g4WWAOECbWfGXm+Em3SsM03ziMjd+DWRbh3jKGWNagU+7z+TAB6CPmSnn7KN1kxk2fk2W44Lkjdbi5qS69M8kaAm8Q6xvg5nV1Bx1YpRyegAjxsJFosAhfZIwMUdSJGFD+jn0D8C27xK6jKptn0wGjIg63sooGYLp1DDMzwJdEjZrTCxogLKTpBl36f/Z07uWmLIF4IlUOMk47f3KpPY3BAl0k69JVHmFiuVhlCm5MaKv97PjrluUwy8Vq2xytHLrLrPPiFiFTBkoMjFfSDyNb+vVOX+4dZdZNea2CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDeUvabnCePhZ+hBtNeMXWa9Iod2XSLJUOMNIgEtylg=;
 b=Jhsg0k3TBKYbVGVMdk3zeu+WX/mqOs9yd5fua1U4QgHGrlPHla+9AbQrHI3p6mOEe4jBlod9MNAB5hDw23LmNqwxUNACZ6NwdqiAnZJi+hC6dNuGzRnHcoSSGXtWZ4FRx786d+e4k2oQh8HAex017u9YE/WPRfvme3wIr8VbfTU=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CY4PR12MB1143.namprd12.prod.outlook.com (2603:10b6:903:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 06:05:34 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 06:05:34 +0000
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
Subject: RE: [PATCH 0/4]Add afi config drivers support
Thread-Topic: [PATCH 0/4]Add afi config drivers support
Thread-Index: AQHYt21yQYv+BXUPKk+4t2KrZ1VJb63CRnIAgAS29gA=
Date:   Tue, 30 Aug 2022 06:05:34 +0000
Message-ID: <DM6PR12MB3993F734C897E98BBA4F6AB3CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <YwmzkNVqgSEIgSKH@yilunxu-OptiPlex-7050>
In-Reply-To: <YwmzkNVqgSEIgSKH@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382d30b5-1e44-4512-0065-08da8a4da70d
x-ms-traffictypediagnostic: CY4PR12MB1143:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKnXnn+ZVu++ddjaf6eiWw98+nVnKeGmqKTu/e3cm5SfPgIYf32VATUy7edegWDzKe1/DWEjcs0gPVBKLLnjPlcnFWgokLAZOb3pPV8m+AZHwZQtj8guscQqPof0Kn4zo1BEDMms5LLfPKUqvt+fEGSD/KyaN9J9ZF7oPTP1KcZb3uwnJz8LFdiDZK+B/+rUcCPV178BzQlQva7DAWitNWZu6Y7AYNH+BNQN/8Yze6KJaPSTevrz/JZvj2elgNYxxodnHVIfSUp0hyzlss5lnoCy5djbHDzkvIZYL30emTW3EUpLczxz7dyf7T2bU1Ux+tjAClKRbOo3RLCxdObjVDhNBkwCgLjczVFONBuFNO3zTtJNdTX5ELVJYAR837lW7xEZV2P6Avq7b2XL+ZIXE1eCl+TTEK0BlQUPFFilgMJtgx6hf/+ai7U2qtjspjBwefFU8Qr8xm836DSN8JGp5RjwZ6n8adoutV9NrzgtN4oWy4Fh31mZ5fQGkNUX3eG7a5vOulBRue3K4pLULd+qVXsK2ObtMCcQvKCi3B0IC3nYLr6IoPCezREGu0XVmK1/kt6WA68N96T4RX58YBSKpEzoxPDtXC5WxD4bv5YKOWyJSP2sk2iockdj+36GpVSJiJ/dTXC+O1uBNFsT3Jl/B3sju1gY+qu+YC1J3DpmbSSeVudw/YqOrYBvwpxQkssGbhWH1jlyeZla3oGb7q6sOEg+FcXnJcqEeKiIEl4X8oA/60ibklLNCmAUXMu8ZS7nfcW81E+IOQcjgA0MHqmC0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(7696005)(6506007)(53546011)(71200400001)(26005)(33656002)(122000001)(9686003)(86362001)(83380400001)(478600001)(186003)(38070700005)(41300700001)(66446008)(55016003)(66476007)(8676002)(6916009)(64756008)(76116006)(316002)(4326008)(54906003)(66556008)(66946007)(7416002)(8936002)(52536014)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A8BWTvnFG8eb0KeEyRYYvFO/Ti79lMxuvGtXfZJVlv/j/hGLX+PRMm1yK9+x?=
 =?us-ascii?Q?/rv7/wc2ZF8oUyyTyE7VVy7s6eveZR+se5aNxt5BJfzBCFrIvFGiHf2YdmKF?=
 =?us-ascii?Q?uPQn3iraCeq44t6qqS71FYhGlXnXfcX3nVMVENBZyoJjmdzEDrSlYLrrpdnb?=
 =?us-ascii?Q?9YPpg6qj+jhXQmBfugEeI/5HGlERupNgUlpK+0c+vU0+lDrIEKWmOUb6dIEK?=
 =?us-ascii?Q?s3MdEEuwm5E/ppB1DYo6nAOzvVZsj94UfPFDjPAXYVoFqaPgGSCUBYZYU1vX?=
 =?us-ascii?Q?fR8El4p54byW5DWM66wWeUDSUaeCvy24qlj4WIOrFeCP2C+zJ2bZNxSjcvnU?=
 =?us-ascii?Q?38ffIkmdX2bl97R6MAdBO5NqhVHxUjLiUWmUWvv8aTS+bZ1bHmfMMkdcWB8w?=
 =?us-ascii?Q?S4ARLY3M45xsW1E+ppdDBCs2p209/oaIm1A3mjAfZ9HQhMPdjzq0UX6DdDuM?=
 =?us-ascii?Q?RD0Exys8W6NrqaAAXkYBC0en/Z4R3MqcJqiI+7UUVHIB94wOM4+Ty171cFTr?=
 =?us-ascii?Q?boMwwXCBDI9xGEmdBdLqx4LYWed5egffE2j1rXgMmYUzt5qjZ7bNcCoflfZk?=
 =?us-ascii?Q?CyIs0G49mKxL4M24ljVhiXwwM/Qbp/TOxKBa+AeJg14A4oja/RtqYzlHbeZo?=
 =?us-ascii?Q?dVcPnAJB4tWzvdhayl68zhOxayHh2fJ9317rgygUYu8Hwm6WpjVeyyySs7Ve?=
 =?us-ascii?Q?tNh6SVeVDimzryyOU3rUByd7DEfe72RtB0H1WSyHsiHVTXpmUy2BIzdf2myw?=
 =?us-ascii?Q?X9mmF+RSrJitJjb3ASJuOLzn7RtdgtK4JPayducOI4VKePguFfTnRwRtWoAq?=
 =?us-ascii?Q?FJRs4PV+qpLsdtC8QX9g13SaxvxSfV6dfUpRiTSxRvL/RQ2HhHb+WvJ6iTjh?=
 =?us-ascii?Q?cfHCJL18Dnt69K6UAWva47zS7hUpgjIrXk23w7vh4a5DMK1/kfSzgrb94h/q?=
 =?us-ascii?Q?duziMvjDZpzCmPD05v68y0ouOCsfyHGfTcQDCYa51hNapAczoRID2u4lwYKm?=
 =?us-ascii?Q?SiKKhXj2UQnpVmSfjjvpmo/YUYz35WhH2bQL/u4FokQuwhNjvZUteH1Xa0C9?=
 =?us-ascii?Q?Tmcg7HJXYc/MeqsgfNIBC7WDGn41NwZeeckcfFfnbyhC37DwIZS+hoZ/qdrw?=
 =?us-ascii?Q?K239b1rXuODQePnlOYsqnVhhK54UmMglp9xcO6xlOMlPIhVdh2LkvHpdEs6l?=
 =?us-ascii?Q?1ZvWoIOC27p8UUMSx98vbRwNBANus/kA7ccmWN1g9Z9bC9ImFvgXVJthHI0u?=
 =?us-ascii?Q?Rj7UQCjIG3qwoKbk4cQ3x/boCplMxm8JRqDK6iR0E+bVh6D7ezLdaULYU/nA?=
 =?us-ascii?Q?y/DtfOuYlfhd1S+/6oIvCIPmphjstqnZRXQJid621K5Y3q7kIXLdklhp3GUL?=
 =?us-ascii?Q?STNhow7ux+ONYJsvnLI6uhr78iNpXpBeFOIzuOE6MeQolZOn27B1iaibwyEN?=
 =?us-ascii?Q?TMqAtYJhKSPhFlYWlrVsYGj4BvJM7Sj9Mn5x6dOHCBq0RewjQ/Mw5cPGDJdj?=
 =?us-ascii?Q?jJZpTgdQB3f/Y0j6vU4Rzn8G+ClFbkSb98mlV7XdSzEtpqB+Wt+qnlG10HJc?=
 =?us-ascii?Q?ekA38QXB6WRW3twRTqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382d30b5-1e44-4512-0065-08da8a4da70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 06:05:34.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdQSLzOVT5pKZ9KGfEJaDVxAJcI7fG16j+TdX/Mtwb2l5Tz+SuKNJUJlKdDz86lF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
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
> Sent: Saturday, August 27, 2022 11:33 AM
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
> Subject: Re: [PATCH 0/4]Add afi config drivers support
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On 2022-08-24 at 09:25:38 +0530, Nava kishore Manne wrote:
> > Xilinx SoC platforms (Zynq and ZynqMP) connect the PS to the
> > programmable
>=20
> Could you help explain what is PS?
>=20

The Zynq UltraScale MPSoC family consists of a system-on-chip (SoC) style i=
ntegrated processing system (PS)
and a Programmable Logic (PL) unit, providing an extensible and flexible So=
C solution on a single die.

Will add PS description in next version.

Regards,
Navakishore.

