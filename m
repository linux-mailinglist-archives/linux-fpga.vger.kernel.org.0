Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD58C37281D
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEDJfh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 05:35:37 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:44736
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229903AbhEDJfg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 05:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF1pcgqDxBI4Y+RTitG9pDID2/r2rY0RJZlUUw1wB6IdHZH7A2F/Yjlx3qnWPasfjdmtLFzVWDqHlYHvf02V5wrfb1FeCg38H4Dmbr7+TrumaVuPjS1Srr8s1OoTKZnPcqYtD5NMwJ+WHo+3DyyV+di91EpM99sAy7x6ISmvhd7TXSLbt/Rap+rbNDxEQxLIx8Zoq+ay1xGKZTrrsdREQbn/Xe25dmisGuuhxRZ9x8B3HQmi7kQuRedBcZOYpVmW9WoQBG4bWT8TTNDJYLVJ78BM75hCvLUpgpY4bv8dRh7P2KGMk5jhu69y8qvNQfMd38GebhX5wFSYRrqENHOvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx3A+BFftR+KQqW3L8uhNa7KF30x8b48/Tky9yU+G8w=;
 b=POa2z5fq1+VKJbAj1U8qLXJeaHqbqHVKDcamLUYO9DEz8xDqgFMKHLGtjJjmY3Y19FHIQhCeclqWhPn2Lr5ejfjj6KkYQaVWjss0n9RUdC/NmyZ/9URWN9Rw6vMXNx8UvnfvGlD69HsaBqd8PKDLlug4DBejmggoWNuIcVfBNOOJ51/a0OiR9Kb2E2uQNdwzoxf6UhJLvA8gfrZ/Uu7GCMZF04NxBjtzbPpZyacb4Tq1ppNykNuamqLRVzSdHxujZjgNni9vdSIsN/L8eLXg/hAMlhY079O6hgOXY6I5VfacX6bnnYoWoU78HgJsHjr+WVG+bwD7/EeYW9GSo+mzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx3A+BFftR+KQqW3L8uhNa7KF30x8b48/Tky9yU+G8w=;
 b=ZhZI7SzRrn1UCf3HcAM67nOXKNkWK99ae7OjH1ybjHdrS9Sh0PLsDEQ8B5AuyfF0cChD49zjubtNW0tetfb5qJ0KVzhmx9cE1+WbkxsMGto6qXZH67iuc3M8ZuQ6OgxNJGVUR9FYrzGFABtNawihSzhq0DKlpyL9M21ZTaT+UFI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MW4PR02MB7202.namprd02.prod.outlook.com (2603:10b6:303:7b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 09:34:39 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 09:34:39 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: RE: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Topic: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Thread-Index: AQHXPQErV0G7SQw9VkmmikpPIEZooarNdzQAgAWeuSA=
Date:   Tue, 4 May 2021 09:34:39 +0000
Message-ID: <MWHPR02MB262372B79B43EC798C06F491C25A9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
 <20210429140408.23194-2-nava.manne@xilinx.com>
 <20210430194000.GA3742101@robh.at.kernel.org>
In-Reply-To: <20210430194000.GA3742101@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.206.49.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63870ab6-210e-492b-7345-08d90edfd6fc
x-ms-traffictypediagnostic: MW4PR02MB7202:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR02MB7202D2872F33067A00C9130CC25A9@MW4PR02MB7202.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKCWUgryUbPSoI5zoKFywOjiLqs+h5CfCeHeWmRbdg1/PO7K5yt99PbV03b5hPpKahGuW8oQ3zGMZ7HugVG0paSEw6MUdG2KNbAVr0z6dHB0n9d93j66qvhtbPFHjYIPFQmtQXamjjAcOAXvLO584yZCY3G8GgcYMdAQ7X6Ze/ZGH8JaJQpe0r4fm6Vh5uAa4hznTIjrNahmXkJxJqdtwhuaqy4gkTDUV4O0dMX/H02XmaQZE6qGqC/vHKPr56FYk1mqk75j2mkfgaIINwO1eRuetW1tqa6McP5QJkn3uztvL0MENBnbIjg8ZeL5stiqR/vfIcOcCDENMe5sd6+Gr62chpsOFZmYCWozojCiUnvU+MeMetHJid0a7c/CAOhQgWK0/9pDR3Vo6hHqKNY/c/PUvdFbys4RHXKRwax9BJ3EMm01EUcNNFAIOTbBUvX9XF+UREBL7aIfdOVpTjjIm0IVOCoThHSje51Bfw2tTjFPgASCbiasV9HjFCZtJdlh5uzG48limZKKsQ5U1GM1y0bxHTK2bBSPAVvjxZzNe4drd+fKWv37t7lLpGzRfPOtKptBWWzercrgCn8TMn90CLiLv4zFf17V3QtX2M3Q8ysXxF9uYevagSbHYA9aj/mELRtOVp/xMhyc74JwIWJCi8dDUajewVP4HEUDNuY68CH3AU1NjaXr9bP5YgAohFUi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(86362001)(33656002)(5660300002)(64756008)(83380400001)(122000001)(66946007)(478600001)(6916009)(71200400001)(6506007)(66446008)(54906003)(76116006)(316002)(52536014)(966005)(66556008)(38100700002)(7696005)(9686003)(53546011)(7416002)(55236004)(8676002)(55016002)(107886003)(8936002)(66476007)(2906002)(186003)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m56OWvCphSpC+W1TjHbQcahmm8pSSqR6PktivYS4ei0Jy6LWD/pEUO7TVjtZ?=
 =?us-ascii?Q?ddmzQQamkEDHCoKp8WVEnME5oInZLboCZ69FsDhzaNBdTsAFmW2a/OJ/vug1?=
 =?us-ascii?Q?W4+A7EOjRZE8Yhs6+Vf4qVANDeyQ0/LzaBALrpOtvl0ZmPrRg+zBiz+BD6qW?=
 =?us-ascii?Q?+ASYuS/pUAJzMjiH44zhtWe57tIX9FSGMpAc0GacYCIuuoK+eFnIoyAt0gEs?=
 =?us-ascii?Q?Gfvt8mk3qL/FqvF5RNo425ueUGKw66Y3rEUkmbfYcw4UHV4T+TUaQWlGdtrY?=
 =?us-ascii?Q?cFWCue13xr4TZl4PcE08W4KittzOb8YmDK3J1s2E+q4KyhR+LRD6Eg/WC/GQ?=
 =?us-ascii?Q?4+D7QhkkuV04zQdesJ1OrX/Gk3F9m1NvveE/gZVLHI75qBxDqOcbfshjEqG9?=
 =?us-ascii?Q?Lj6W5a7/AoUzUlcNhUJUKOrYlPKNY3jz2bzzosH7hq6BkMhQbmVR6vLoddMq?=
 =?us-ascii?Q?Spp7A1d7I61Bt64vg+1RGk8cjZ7aDu/H+7jeWZQXvnQgmZALOnYf0oX31WL7?=
 =?us-ascii?Q?1xSmedEZgiQZE44lfK49OLS5PAjfKEcQlb+a9jKh/ZUcdLl2JExuuEEPnv1U?=
 =?us-ascii?Q?FtA3YF9jY21y0Vp19clQNT4F/qryk1rr5qUhDNHMVQV4/60czirlJCRProPf?=
 =?us-ascii?Q?ohetSyTBspBWnxPfTzXW5ytUFIe/Aj3iI3jcy7IKtYdsrzlJUnnQzFW6i/O3?=
 =?us-ascii?Q?p8LcZwPA5Jsh850u3KVpGpYsNTVrGjWfrc2ZVlYiMvvo6ECZWggKj0agG7bD?=
 =?us-ascii?Q?oc961epK4TGfV/K51k3QlX6dXARD11d+YtHZlQbDiP3+I0v3ca6SeWEtX5ei?=
 =?us-ascii?Q?deTwqy0v/o98Vg8nX+tTM1YDL38LInSqcwqRmR7PUaBbhFshePGUbm4usInw?=
 =?us-ascii?Q?zr4cmUSVspyI3E7uxTfZRh5tweZAdEIQu3+ju3kX1XcqakG94G21rEaakYbT?=
 =?us-ascii?Q?qcRlnzKu91Xw8tfiQDwk3JMfucOTzKbTTgNr4blGIGHrJRavJdrKFIo23Y4a?=
 =?us-ascii?Q?2VIOlYqaqKicvkdIAK9GYHs/1RTKlTdXpl/soeFNgIxqWehkCqudj0EQSDTU?=
 =?us-ascii?Q?qMgXnaO5YVYTNUgeQt01vrN+TfTPbOfG8V/iT21KQ0ScJeWO8x3+mVYh9ktO?=
 =?us-ascii?Q?ZMviSBs5SiQVrRKrNDXik7MASL5G8kHYU7RKzu12hRdjqwXQGUJQcTz58Q7y?=
 =?us-ascii?Q?pdd6uI8QIZfBC2s174+ToNJnj0hkXKIswq+abcp7BXm9PizwcPvf6sEkxf+y?=
 =?us-ascii?Q?CthKoOYIKBgXlCxTlh6u1QprWQbgRq+mNNF9DOqHLJXhkj5e2qa21R+/KQpR?=
 =?us-ascii?Q?5ysSI4B8Xmu0IuLUu9a8fam4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63870ab6-210e-492b-7345-08d90edfd6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 09:34:39.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTEv7LjHNY5sLZPFkeblneMK1SPhQq2viHmXDTSyjV0TPzitMksuBrNq/LI41aEmBN0gE/IeCQQ6N6enMamlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7202
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

	Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, May 1, 2021 1:10 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; mdf@kernel.org; trix@redhat.com;
> gregkh@linuxfoundation.org; arnd@arndb.de; Rajan Vaja
> <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; iwamatsu@nigauri.org; Jiaying Liang
> <jliang@xilinx.com>; linus.walleij@linaro.org; devicetree@vger.kernel.org=
;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux=
-
> fpga@vger.kernel.org; chinnikishore369@gmail.com; git <git@xilinx.com>
> Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilin=
x
> firmware
>=20
> On Thu, Apr 29, 2021 at 07:34:05PM +0530, Nava kishore Manne wrote:
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
> >
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 63
> > +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmware
> > .yaml
>=20
> What about the old doc?:
>=20

As you suggested i have added only the fpga node relevant info here so it's=
 not representing the complete firmware file with other sub node like clk, =
Aes, ...etc.
Once it completely mature we can deprecate the Old doc.

> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmware.txt
>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> firmwa
> > re.yaml
> > new file mode 100644
> > index 000000000000..4b97f005bed7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.yaml
> > @@ -0,0 +1,63 @@
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
> > +    description: The method of calling the PM-API firmware layer.
> > +                #  Permitted values are:
> > +                #  - "smc" : SMC #0, following the SMCCC
> > +                #  - "hvc" : HVC #0, following the SMCCC
>=20
> Drop the '#'. If you want to maintain the formatting, then use '|' after
> 'description:' for a literal block.
>=20

Will fix in v5.

> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    enum:
> > +      - smc
> > +      - hvc
> > +
> > +patternProperties:
> > +  "fpga":
>=20
> So 'foofpgabar' is valid?
>=20

Yes, it's a valid for fpga node.

> > +    description: Compatible of the FPGA device.
> > +    type: object
> > +
> > +    required:
> > +      - compatible
>=20
> This belongs in the fpga schema which should have a $ref here. (Which
> means this patch needs to come 2nd.)
>=20

Will fix in v5.

Regards,
Navakishore.
