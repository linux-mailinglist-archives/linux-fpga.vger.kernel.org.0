Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0513B4F3B
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFZPki (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:40:38 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:20704
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhFZPkh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWwpQr/2/iKV0zsjDIiz04alMLzqBtWla6AhbSCdvBstUtejw49lg+re7Si5He89VZLBKPNe+poi6Y3WyIitji0cmsfiVuZx/T/ZsiocIOC3vIqsEwSl1CViE7AbCHTbAdw2QFMu0PHz97A5occG3I8fg6M26LpZV9LqPcqvypabt7m7qV0Ruuuz8oK9yWRaPA2szWMIKS9YMGgCJbg80jy6+voqJ3q1PZMNRVSyDs9/ptpufEhwadjLJB1Z2uPqGbvP1TCqalO6XseMonEcS4W/7oq/c4WffOC28pDYfIO1Q3+Q2rjzkcVxc1DuyAcGejsKVTbEUp6vwUfgC7yMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FILdz8TiwhkKk5gwqOsr38XQJWAoEqQBLMz/+O9atPM=;
 b=dFmdbUjfH+0G/iceJODG9XNKVqRst/q8OvSmpqkpVfNYUet1DOCJ/nGNK/OeVOdgT/HIwPFCg/5G9QW/p/duUgUK8HdyvvaF9UKdr/5+1jv2viEFXOrJ+z1a7pjPlAhmiV3z8zz8w5sfx4JZWZTWwgtIhTx3ZaRpuEkpF8Anzb8fAkYTTYZoc+h7v4n3I5I5IWRJFYXTgRXp9aBkhLeJjje/F8Q39q8tQulPyGr1/RVPTl3yTQ0wRc/CdRsx6ixV98ZJUh1rEkaOy6buaI3tM4RFdSnS7YlLlVW1oFRj3ISRhFN8Rdbn3h/OfZg4gbBWha+QUfLNK/EuX+s+fDCo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FILdz8TiwhkKk5gwqOsr38XQJWAoEqQBLMz/+O9atPM=;
 b=AmvyVfTZplkBbwWgDVPg7REpZfBRtlyoGZbB8EY78/QwLQDylIFq1TmvpZfLVB4QB4os9F/bdyikFFbqRDBNwEatVvDRPyrJKi20AslxDBF+xhY2dkHgeuCr10Ztu6oMshH5pFn/KnwGfLX2OQwQOH0SxLCHokwGrCR7tyFjeSM=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7381.namprd02.prod.outlook.com (2603:10b6:510:1e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Sat, 26 Jun 2021 15:38:01 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4264.024; Sat, 26 Jun 2021
 15:38:00 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <RAVIPATE@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH v7 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Topic: [PATCH v7 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Index: AQHXWTWLvlOlGYH4vk6tnK9on7ZPFKsNcfIAgBkc6RA=
Date:   Sat, 26 Jun 2021 15:38:00 +0000
Message-ID: <PH0PR02MB733685A0EE25D098C7A080A2C2059@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
 <20210604113332.1394-4-nava.manne@xilinx.com>
 <20210610160342.GA1883933@robh.at.kernel.org>
In-Reply-To: <20210610160342.GA1883933@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91835715-5912-4b34-21f9-08d938b86171
x-ms-traffictypediagnostic: PH0PR02MB7381:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB73811088115D16EA2F8101E9C2059@PH0PR02MB7381.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWSoeOmg1oyWYbrv+KE9I8bH6nHUBVq/b0Jt27vKUmZOf1OSI4adsxaAEalzc9Q/z1YSSJM+P8fc8tA6W8PHswUFbVi20Muoyx5Oko1Xzx2xRcX+R4IY1TnfvjpyFFh1BYePGBe1N1nXQs2/4byAq+MQsma1aR4T0r/k5wWQqzAzDQnYjndCegZSUWvw5WWdopldK2W7kwUOq8ddX9dxDUvp5UNAhsU5F2NhbPcchLbLghUt6OEM09EreideklWJi/WDJ4grOpuk7Pz7ChPJsZyo22+1Rfl2UprKyjRCm4Oj09IwA6HmvnjIRwUm8z+W1xeJwvKvNEze5+aqLLzGMjqqsT6O410oDFU72qU6cXCRZ5DYNpFpLRk6MbqCVjrEueBZy7qs5McGGoIb9s5Y/a/4hVRuC0Y7QNra7sc6Ly6I9hqQ7EcoktcoBwVliH+wJrh3f9yDm1Wja10b095q4KRt7AMfYz9iFsAPXDomwlEEOK5AnXCgEvqSC4b2wtHtIYyKd9nGEVrdK3+PR7PSovKGzFQU6nUVNC23gK7ZtXFQ9CrcsnN9nRnKZEaoMUpUM0MTT0cEER7gf8SHxtlvy4FgLs0BByuS0NM00P+i0Nwk2SdSbQQpQUs3g0GzjwiRpV5U2KMkQfzFohG7MFZ8kfJTKtsDcMUbemyXWDjidPMcIV1u9wERj5pX+JLr1EUrNnOdRcbqaYgJplbBFLEIOGzRMKvc3QrPKh/FBqULWpwKPQJRPhea0Y0qKubD8O/QsZoTkdj2qHMivtRn9GyEfNL5u9Z2HqjOKZAfCj2MDP4ajAaRJJpCl8Kx9crUeNq1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(54906003)(33656002)(9686003)(2906002)(186003)(478600001)(966005)(316002)(71200400001)(7696005)(6506007)(6916009)(26005)(4326008)(53546011)(86362001)(55016002)(7416002)(66946007)(8676002)(76116006)(8936002)(52536014)(38100700002)(83380400001)(5660300002)(66446008)(66556008)(64756008)(66476007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mhWxlyQHt2qAWXbsmy6QnSDfLgL0l3XVdGQLkwl0mWFDDsoMWiFtAxLiWF1d?=
 =?us-ascii?Q?93Y1nhI4jLcJkMc6+2kku8hbAHN5m9DZmKbWpKif6qjPMd+AE3vYKCYKIgFC?=
 =?us-ascii?Q?zXf3Yd9uAp+U8+kcgEvrSs2tereWAtwxmA4ZSXMZXMpcXHvReGSaDUQ2yoUr?=
 =?us-ascii?Q?yIdBKHXOgP7Ny7oW3P16uTB81eOAi4pOFSQ9+nGZ7OW2xHLd8EXc9SCk0AmF?=
 =?us-ascii?Q?EuQJepqYsZeLJBqx7LpNDK9YzVJQS7bV2A0Sh7hIu4GG6NwU3fm6SrRn5gBV?=
 =?us-ascii?Q?1I+kANwQfjuI2UPHRhnR46jD8oMW8aX7aYKgK/JdjZX0znl5SJ6zqjzKjmRq?=
 =?us-ascii?Q?o4ozUGG6k0T03EDLiIiRZTASsY/SoXo/3DODtyfpD9LoJ8XtfjxBSC2/dR37?=
 =?us-ascii?Q?YRlqXBeq9N2kc8I/CMri+1TTNElRqetjL3iqPM/+0Dohr6G1gHgPz26OTffB?=
 =?us-ascii?Q?q9wCkSH6zqDsiA42yQwowCpgQ9yxU5eDogEsRzjZInzDW4ktOUx6AGg2l899?=
 =?us-ascii?Q?HcXI+JHDSO7hMZcDkVDj+zfgO0NEQTnUUftNmz3Rwp1VGaWh0erhAZAUvDdh?=
 =?us-ascii?Q?H+X94oTdU9tafdotFer8bzj9Xkn4TMf/nZVMJEwVscv5ANEBp41geJpd5ZiJ?=
 =?us-ascii?Q?gwQU5jMHFW9t0TfYykSqpwSwUDgc1hBi6oPvMfTiFCHOdDP/xOa4sh2hQwFa?=
 =?us-ascii?Q?x7pfjuoXLtB/yTbUyS79l6gjO1wDb+DqQTDojUoXCj91tzaf2BYYkiOtypsT?=
 =?us-ascii?Q?0HpqYdNN9DzJIE5qfZw+VMpYOOyAMhpa9q0u35A8/or2jrMZgTH/Q1WOuOfi?=
 =?us-ascii?Q?ukVmz7hgfGcMi2TIhH7OBFamxLREhg9ul+b4a4p6gOil0cWkjPTDoUIGS/dH?=
 =?us-ascii?Q?GquX33Z4f/n8FQLrG07Fj/bZoLS1kzoEmbYDQoXprZC8+9KcQwyE2qeqy16Q?=
 =?us-ascii?Q?9nxY9cF3n/zWNZMobNMipdU8cJSuYawbPzrQcw8NLJupUG06SFWHro1sc+g3?=
 =?us-ascii?Q?b7LXgzRhswj3KqliR88kMj1f8EnrgmqwtmhkJMotEwF8bEUJUQzkJ9cU3dIG?=
 =?us-ascii?Q?At41QSt0QNFxj/wOi3z80J5yEnjdGo5bCzZOQCu22FwujYe5AC7nFUOF2hV/?=
 =?us-ascii?Q?Qdz5bUIxH5X7bjPsNAS1ke5JF0dm7BTcmL+41yByP05yURo67jkOxlcgqoiF?=
 =?us-ascii?Q?75XAvhdqoeDzsNKCMF3ZGT96U7aXR8u2YQ2A2SRNti0EN36sef+v6j4MfilX?=
 =?us-ascii?Q?D7Z31jOQkrTT8t4DCdm5mULbrTsbRev/i727btAjK648mhLGaQt8zvgl6he1?=
 =?us-ascii?Q?6/KigVdLDN1gdwZL3VI/EU9n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91835715-5912-4b34-21f9-08d938b86171
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2021 15:38:00.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yufclNAFvgHqoMSeuwOAZkonIXNDgXwNWVfApubei5ifQZdALP2D6CDeBgCdcrltbc/ilRB2i60p17A1VPfC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7381
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

	Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, June 10, 2021 9:34 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; mdf@kernel.org; trix@redhat.com;
> arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>;
> gregkh@linuxfoundation.org; Amit Sunil Dhamne
> <amitsuni@xlnx.xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>;
> zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>; Ravi
> Patel <RAVIPATE@xilinx.com>; iwamatsu@nigauri.org; Jiaying Liang
> <jliang@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> fpga@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH v7 3/4] dt-bindings: firmware: Add bindings for xilin=
x
> firmware
>=20
> On Fri, Jun 04, 2021 at 05:03:31PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx firmware driver bindings.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to Platform
> > Management Unit.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v4:
> >               -Added new yaml file for xilinx firmware
> >                as suggested by Rob.
> >
> > Changes for v5:
> >               -Fixed some minor issues and updated the fpga node name t=
o
> versal_fpga.
> >
> > Changes for v6:
> >               -Added AES and Clk nodes as a sub nodes to the firmware n=
ode.
> >
> > Changes for v7:
> >               -Fixed child nodes format ssues.
> >
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 94
> > +++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmware
> > .yaml
>=20
> You need to remove xlnx,zynqmp-firmware.txt
>=20

Will fix in v8.

> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > new file mode 100644
> > index 000000000000..8e0241c4c137
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.yaml
> > @@ -0,0 +1,94 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.ya
> > +ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx firmware driver
> > +
> > +maintainers:
> > +  - Nava kishore Manne <nava.manne@xilinx.com>
> > +
> > +description:
> > +  The zynqmp-firmware node describes the interface to platform
> firmware.
> > +  ZynqMP has an interface to communicate with secure firmware.
> > +Firmware
> > +  driver provides an interface to firmware APIs. Interface APIs can
> > +be
> > +  used by any driver to communicate to PMUFW(Platform Management
> Unit).
> > +  These requests include clock management, pin control, device
> > +control,
> > +  power management service, FPGA service and other platform
> > +management
> > +  services.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description:
> > +          For implementations complying for Zynq Ultrascale+ MPSoC.
> > +        const: xlnx,zynqmp-firmware
> > +
> > +      - description:
> > +          For implementations complying for Versal.
> > +        const: xlnx,versal-firmware
> > +
> > +  method:
> > +    description: |
> > +                 The method of calling the PM-API firmware layer.
> > +                 Permitted values are.
> > +                 - "smc" : SMC #0, following the SMCCC
> > +                 - "hvc" : HVC #0, following the SMCCC
> > +
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    enum:
> > +      - smc
> > +      - hvc
> > +
> > +  "versal_fpga":
>=20
> Don't need quotes
>=20

Will fix in v8.

> > +    $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
> > +    description: Compatible of the FPGA device.
> > +    type: object
> > +
> > +  "zynqmp-aes":
>=20
> Don't need quotes
>=20

Will fix in v8.

> > +    $ref: /schemas/crypto/xlnx,zynqmp-aes.yaml#
> > +    description: |
> > +                 The ZynqMP AES-GCM hardened cryptographic accelerator=
 is
> > +                 used to encrypt or decrypt the data with provided key=
 and
> > +                 initialization vector.
>=20
> Don't need '|' here (there's no formatting) and indent 2 more than
> 'description'.
>=20

Will fix in v8.

Regards,
Navakishore.
