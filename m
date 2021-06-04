Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8656939B413
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDHip (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 03:38:45 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:23327
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229973AbhFDHio (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 03:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkAFzxYd/0llXFSG7LtgFUeVx19OVls5OIHk8vYydbkIo6ujbFI4baACjQUYGf3fZxCrtGaRBdv0jadUbeGJgPQdBJlf4ZCU8QBmAANeV1Z3OA0/DUIkkgQAWBNgqa2QUV1tbjhOakaMs2ObVkjXD5XgsaM3kWSYVRkx6G2mIpbtKlIFFAEOzcO+jU5TDFcfr4YwPxHffYLlq1LQRdh9XbdYh1B/WJY9kAuRQ9BF7yymWPJ0IterlYXVq+Y3VHq8K0vYhqc4hjf67G3LxUwS9BaGaz8W/5rDiZiSNlqykFehPYdivCXWQk6eX6w8+jWjRdGppHPTiagd+wy5+q6jsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLe4LcrXghcPkGnbl89zLSZIDRkyNMglgDJhbs5twBQ=;
 b=Gm/FyDJMl/BzTcP1N6HP1hO6QLKhG/B2DlQNB2SgBW3y+eRpGyyQpSr3AaboHiWi4WcvjMYeY8o3vK2maaww+O80Hwz7Eu6ZlR/R69RWTfqRqDON8ZO70lJdOIuidfiZZogewaOmmIIH76K5gZDsjz2nZOoT6SjItdrnfrowKC+JbGnnUx2+A7aNbHqk2G8osP2xviqJ/iDs62x5zAJhy3SAhdBH+HREs9wolrXmcbx1jC40QcfzG1DONDzulr6KzQkxkOzlbtqquV4Mfs2IJJWPDRSFeO0eNb0MecqERKRrq5qZGc6GT1B/cHyquBxCECYe6/pUOsmXDh/n9jof2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLe4LcrXghcPkGnbl89zLSZIDRkyNMglgDJhbs5twBQ=;
 b=T1p0n4OqiklfH+djgxhjkx3vniuXBgn26Gyf7IkNlTEt/XOt2aLdHQ4D+1LOurBsIqNHXX0dpdD4qg6KDG1E/nG4aVso9ADNc7bH2KQBU5NZ4Y2ACVxAYANqZQfOH7zHtVKvYTMLcxa2AH2kAczTTtTyvXpb7hBOKpgeN2JjN/Q=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7205.namprd02.prod.outlook.com (2603:10b6:510:1a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Fri, 4 Jun 2021 07:36:53 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 07:36:53 +0000
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
Subject: RE: [PATCH v6 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Topic: [PATCH v6 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Index: AQHXTU+iEF35WlZWCE+RLpdahH4hlKsBIGSAgAJsNQA=
Date:   Fri, 4 Jun 2021 07:36:53 +0000
Message-ID: <PH0PR02MB7336CA9287C41D64CBB4D5E2C23B9@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-4-nava.manne@xilinx.com>
 <20210602183131.GA3706177@robh.at.kernel.org>
In-Reply-To: <20210602183131.GA3706177@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7d6008a-a79f-4d4e-266c-08d9272b8637
x-ms-traffictypediagnostic: PH0PR02MB7205:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB72051F6A0C90BF529A2539DDC23B9@PH0PR02MB7205.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rim0QzAgrhKc8s/KgulUPUGPlzkAj2k4takCwEN+mEw7CjpcRYS5yOIkr60lhmSAcXbeA2kZBhfW1OEZNCNwpAljX+w+rR+A2b6gWkceHiHg3W8UZmLB8ladcUzSIKloC7eIir0xYiLuwbUdJ2DgB0AKbsGfKIr0K3MeLW7nAWqURbjqXPAsLi7GUmrmrv8UtteOTuzytysUX1N4FK5hualOw/qdIkFAL7lNKLRB4gpric0PCLjtY2Q7+oaQG0U73VQs6b+77CRssLf3caOFIpDhkr5T4ZetQ5ZKVIrVSgb/kIOYd0n9rBgYUxHknJJUmNxoqXMu7C/Xb2zoq7VbNCAzYzO/35qzKixnNFYT/XszhwUZIe47C3S0MfzeLQIkC8ZlHy1oc/zyVqySIqR40sUMOjtHlTtP2xduCltJ+sFMnyfm28NUfZO45SJCIXrjUmP0jLDBgrNFl8h56QKG+w1Xm13A1rDRPoWkB8nw6J/c+4wQHjnl0MO3EN4o8Khw8yyCH+yEXL0U1Wk6tOZrlhlayZyWE+oCoU6UulmsoNA0uZaa255yQuXfet+se7mfUXCnxs9aIYjBVAznsOd7KQNDg/C0UwlWKiQepO6vRD0TJsQEb+6yRmxAUMjBuccJcqx2OOTgoFBYZKUxg2Y1qHpPXlFTCXk4Kkcxh5v20XgGdRqnOuWlb1NmT4EK6zdVzg7mg3omXBipAPFemLimuiGIdFi+reWCoS7mF2uYxFy23IieChXduIUHEgyFHvIC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39850400004)(346002)(66946007)(66476007)(38100700002)(64756008)(66556008)(71200400001)(76116006)(52536014)(4326008)(66446008)(478600001)(122000001)(2906002)(8936002)(7416002)(5660300002)(6506007)(8676002)(83380400001)(186003)(55016002)(33656002)(54906003)(316002)(53546011)(7696005)(966005)(6916009)(26005)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?658fSSexAtQGcOtYCEGapDaJxn+sI/zJ3fEZzTACnKMvuTSiD07mEWiC9AG/?=
 =?us-ascii?Q?fvM1+JPcHhGbAzD0wdf607HVtyD33MCyrgoc3KeVhbmLurR8pByoifhNvKVN?=
 =?us-ascii?Q?esUbqVPybSh3YaN4GN5AZmYgxiOmO96U43sMYFt88soFe+BpxKUNvkx/lnSL?=
 =?us-ascii?Q?gHYCpzkIlwtL+8bOqP83CyUkufwrw3YQ0iBEO4eUGFVoY3wtykVAx1Ttc+HI?=
 =?us-ascii?Q?+EJAgcB9KUZNN5GrpcXuy3Eapnq5IE5YheWhUEr1XbPNFK8CpxauwnJsiRKD?=
 =?us-ascii?Q?PcBhdyUtaAPex9+8QDhnZyfWiWrVytNcjD3Jr55c621ROHh45qeoKf12W8++?=
 =?us-ascii?Q?MslDqBWnuQE4qeRm37zpJ/I6jDfF8acagV7DDG4xv7ROTCUdjW9ny7KcdFNC?=
 =?us-ascii?Q?9ZD5b/w7xVPvM01X0+3UfnhUmgCr4tYf3GJy1u5u+tVGC/aX91SATSrR/h9y?=
 =?us-ascii?Q?Ux4bfXS4MQqJauADJ0Oil2fyuw8ptvsRQ7JWp/N5y4zts2vRxc5scQ0dLaeG?=
 =?us-ascii?Q?3grC9aG7Vfw0gSWjr2TQYjYpgyQ8kGL8KGF7EfewOH/mRTmIlHxK2pLiQtvc?=
 =?us-ascii?Q?pE3jwQfUBLazAy3EWZwWyip5DUaiddjUEKCeHbJQUMK56SLF0vnW5Jce9Zh3?=
 =?us-ascii?Q?tAL8ehVJ4QDofiqWJ8OiA2bk0sHRTP9syZSXxuRMJG5J8YGkR5LcFTfqxczn?=
 =?us-ascii?Q?5JzmrrTOXj9ussavzt9iNjyN3XOycBpyG81MudvCxEYDztuUqJZR17EcfnYB?=
 =?us-ascii?Q?+hprMA3kvAuPMvdtLQkzfv8cnxGqZxCkQiBUi1VWvdC4yxhhg7nzq0VXKz2c?=
 =?us-ascii?Q?U0qIcs7pK/wJWR7F9UDnoz/POliSE26uzvrZS9OQ05C6AdhvdFq/n1KLYa1l?=
 =?us-ascii?Q?FJE7/9VWFmEO0Ul+RUyIg66/8b//3gNp17ZxUqcd+JyUrbL0ygapmc2XbKMq?=
 =?us-ascii?Q?+azhM1x43Fu2b+5qCQssX+iRtDMmMTmtDnyTBZToUPVUreX+CX2WVEDhvBzh?=
 =?us-ascii?Q?bsVUVWLFS22RWtDPrfbP5GJ1KTtSM4pbThxx+fm4oKpzO8hIG4F3JD65cxX7?=
 =?us-ascii?Q?fR1rxh2SPd23h7z7OInsMaZ1iwWfaOwp0SC7i4xMkGEzn0GRdaK70/O2Rb/s?=
 =?us-ascii?Q?xK78zIhx45fseOw5ZoCTrKR9Dj7zOlSZeLErBULRha/unS9o3wTWOgrK9epw?=
 =?us-ascii?Q?0ofmkQpxHeZreC9xBnwGTA187ZvCR6b1B22Dv0VC821aDJPY9r1PxRHit26r?=
 =?us-ascii?Q?C7MufzqThsSHNejiLBft+PsgxxujquBWGcLvtscE0B2+GOaXmmjex0RC42j7?=
 =?us-ascii?Q?PWjRiok3yuqmjecNDL3FdwPV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d6008a-a79f-4d4e-266c-08d9272b8637
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 07:36:53.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JXob7gKf5sNm5sH/3IX5mrBOAy9NK9E04eDrd2P+9og9hIXp0UnEqv4o+wRAvhT/dasubm6JXvXbxWQkvXLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7205
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, June 3, 2021 12:02 AM
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
> Subject: Re: [PATCH v6 3/4] dt-bindings: firmware: Add bindings for xilin=
x
> firmware
>=20
> On Thu, May 20, 2021 at 01:39:53PM +0530, Nava kishore Manne wrote:
> > Add documentation to describe Xilinx firmware driver bindings.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to Platform
> > Management Unit.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v4:
> >                 -Added new yaml file for xilinx firmware
> >                  as suggested by Rob.
> > Changes for v5:
> >                 -Fixed some minor issues and updated the fpga node name=
 to
> versal_fpga.
> >
> > Changes for v6:
> >                -Added AES and Clk nodes as a sub nodes to the firmware =
node.
> >
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 102
> > ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmware
> > .yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > new file mode 100644
> > index 000000000000..58016191e150
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.yaml
> > @@ -0,0 +1,102 @@
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
> > +patternProperties:
> > +  "versal_fpga":
>=20
> This says 'fooversal_fpgabar' is a valid node name.
>=20
> You don't need a pattern, move under 'properties'. Same for the other chi=
ld
> nodes.
>=20

Will fix in v7.

> > +    $ref: "../../fpga/xlnx,versal-fpga.yaml#"
>=20
> /schemas/fpga/...
>=20
> Don't need quotes.
>=20

Will fix in v7.

> > +    description: Compatible of the FPGA device.
> > +    type: object
> > +    required:
> > +      - compatible
>=20
> Drop. What's required should be in xlnx,versal-fpga.yaml.
>=20

Will fix in v7.

> > +
> > +  "zynqmp-aes":
>=20
> Same comments as above on the rest of the child nodes.
>=20

Will fix in v7.

> > +    $ref: "../../crypto/xlnx,zynqmp-aes.yaml#"
> > +    description: |
> > +                 The ZynqMP AES-GCM hardened cryptographic accelerator=
 is
> > +                 used to encrypt or decrypt the data with provided key=
 and
> > +                 initialization vector.
> > +    type: object
> > +    required:
> > +      - compatible
> > +
> > +  "clock-controller":
> > +    $ref: "../../clock/xlnx,versal-clk.yaml#"
> > +    description: |
> > +                 The clock controller is a hardware block of Xilinx ve=
rsal
> > +                 clock tree. It reads required input clock frequencies=
 from
> > +                 the devicetree and acts as clock provider for all clo=
ck
> > +                 consumers of PS clocks.list of clock specifiers which=
 are
> > +                 external input clocks to the given clock controller.
> > +    type: object
> > +    required:
> > +      - compatible
> > +      - "#clock-cells"
> > +      - clocks
> > +      - clock-names
> > +
> > +required:
> > +  - compatible
> > +
> > +examples:
> > +  - |
> > +    versal-firmware {
> > +      compatible =3D "xlnx,versal-firmware";
> > +      method =3D "smc";
> > +
> > +      versal_fpga: versal_fpga {
> > +        compatible =3D "xlnx,versal-fpga";
> > +      };
> > +
> > +      xlnx_aes: zynqmp-aes {
> > +        compatible =3D "xlnx,zynqmp-aes";
> > +      };
> > +
> > +      versal_clk: clock-controller {
> > +        #clock-cells =3D <1>;
> > +        compatible =3D "xlnx,versal-clk";
> > +        clocks =3D <&ref>, <&alt_ref>, <&pl_alt_ref>;
> > +        clock-names =3D "ref", "alt_ref", "pl_alt_ref";
> > +      };
> > +    };
> > +
> > +additionalProperties: false
>=20
> Move this before the example.

Will fix in v7.

Regards,
Navakishore.
