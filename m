Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05737333AAB
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCJKuX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 05:50:23 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:33756
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232459AbhCJKuA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 05:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GScYG6ptiRA8NIras0eslyXjBjaLDKqRFFrhsVaqvF8HI6+NGk1PBhmUmmz6x95gHtKYJjMiZBlkO2zjdIpXgL5L0tM/DDdVz6AkD34ZibcId0xlfKupZdF3Zbm8NpyVPuI6ZG82LAR0HcDoUi4WtzoFiFhBa+peQ8GKeSTgE5V2oSpUlplMxoMVp/PShofJBY3veTP5WM8s2ItJiN4y0bJtkoDklDdIiJV4UBIjU2+G50UXoi7a28xT50uy5t9M75383J521lPV+a03iP3frJZO1Z1vLJO0z/OHZewxb0EwB0rRf3gk2MKVH89Z/PPMJwqoFrJaLfaRw+ZbJofw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ncDHrv0nPwx+g2fs3HBWT71veJK73VQr+TFIgK8q+Y=;
 b=iOa5KGzsnqtjrilz6toX0YrVTgSqgUb5lti9PrAYIXPSgn+COCuVRYQHZgMFEmUye12PtVEIKO1Lnp3PmJ8t9AejBqNbINtT3PEUj2W2cLMgaDvQDGKoAUqCv134lj83wDvDUQYwj1SBa0XXBwF2a5S9bXAzA4EWfYfwTg0byGAzBVu5kHB5+fj0448cO4CkyPj6BU+EK6szSsgxhKi0rP4+rjI5p2OCoFdkWsHlX6zqU+Ari2z9JeJGYfdlXJ20KUIUnABTZPMiMgCfLvDNNm9TG01RckAQBvznEL8VwsJ7kPXPYzWjDvMh7NQMvg1fqzV+HRkUOjjEaH0PJp/+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ncDHrv0nPwx+g2fs3HBWT71veJK73VQr+TFIgK8q+Y=;
 b=GhNEhFjxij1LHZ6rs759QXXZiQVwGc6yliroqrJuus7eWT+GJkWvD93LfLi+hEHa9n7+pWc6toyrGo2CiX7dAkdCLokXbGHiumBpd2ll1WimYsYHCEzMyOlc6z3QZRbbioyv6PKWcLk0TW6oTfpGWI+zKbVJmgd56z3UNt8YAjI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB3149.namprd02.prod.outlook.com (2603:10b6:301:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 10:49:55 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 10:49:55 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Manish Narani <MNARANI@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga
 manager
Thread-Topic: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Thread-Index: AQHXEMVdMsyP8+vbRE2oyddQhLKezap6jzYAgAKDMvA=
Date:   Wed, 10 Mar 2021 10:49:54 +0000
Message-ID: <MWHPR02MB26231DD759D8C9D1CB26EC1EC2919@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
 <20210304070224.22346-3-nava.manne@xilinx.com>
 <20210308201944.GA2886704@robh.at.kernel.org>
In-Reply-To: <20210308201944.GA2886704@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c492a54-356d-4f79-a8a5-08d8e3b23daf
x-ms-traffictypediagnostic: MWHPR02MB3149:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB3149B55AB7700CE150003C58C2919@MWHPR02MB3149.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TE3m84TSrUTUiTY3kfjls8o9AF1T9aj2iEFxQm64YbCfO/AIhpbtTRW2n/OQwPMBWh1cCncRjjP2MpT1gW73zf052YFzCXAyRMSpBH+mL0Pt64jfeQ1TlyB9Uo0qfSezza1J9S4Uw2m6GRh2FfYcQVS4/EycVDXsNKD0kHQIuzmq5ATekdOw89DZyIvVEW3ppUr447HCD9NWyGJWwJMZK2UC1I1KAl4Oo8C4CL86xALmUdwXpJfr72ubxVKmiUm78i2Yz+unRH9Bas6Z32Gmx9vpctkSwV0tM3pMiKPv8vpapMHSCGJKTdYbexxjilG5QMYZqYTvWQ/a30AOrSbnVg2nRs0YyuhNbh9LIbp8jsyhLHiLUEzCO0USPgxI0BU2IAY6Nueextcqg9ECVjfqNGMBBEwfdBSM/R+5wLoBGIF9nYT1x43J2qLiVFqx/41dwEPhawNK/62mFrirnPGPLY60oHidlA6wLSeBEgQ26j9jhaWsA+wBItc5NkH1zDvmL96AGqIlCArtKv5sCuRE5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39850400004)(9686003)(8676002)(33656002)(2906002)(54906003)(4326008)(8936002)(6916009)(55016002)(64756008)(53546011)(76116006)(66556008)(66476007)(7696005)(186003)(66946007)(5660300002)(6506007)(66446008)(83380400001)(26005)(316002)(71200400001)(86362001)(52536014)(7416002)(478600001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H3XmiXd2L5Ik5xsmAmRH+4dxrLTPAzt/GIUoG4szw7AKi1lP2iWGcsJzyi4J?=
 =?us-ascii?Q?Kh39rgVL03u+a6tm0Chk+Tf+qB3CV3lo3qZ4NRzRHS+MKcorBlLD4dwKy2n0?=
 =?us-ascii?Q?ZAfPtyXWIoARHaT6YAIXn/MWUr4tNA6Hor3LrdGa6B9qir6lQN+X3c7PoeEj?=
 =?us-ascii?Q?Ug1rCHjWXOJGHFkTG5oa3zmLerB6eZfDbjkm3ktStJPdGHfrBqQx6h8uwpmu?=
 =?us-ascii?Q?SKmk+q4UH0AJpMJQZi+Yd0x2T2nNefbjyWsuxnFx+R9KNAfXnPlUPuAizyCG?=
 =?us-ascii?Q?hdpovlWp2lnLZ5xlGAnpmCA3xcXP4GrZbAC0doUkGCR0W61nj64r0nhU47Mk?=
 =?us-ascii?Q?BdEoTgQ26GIAc27xuyqb41hOmaoV/WMpXvb+wlkSL3HnFvioWVQQDymiGofw?=
 =?us-ascii?Q?Vzmu3DRYNP9bKwBemUuJ9AiIUXuLIUwp5PrieryXTIo85fKl+1nTWloxdZ3O?=
 =?us-ascii?Q?hW/sOb7q6agqLvPDLkC5pB7FqA9qhVaGzrLbSR0QLKw+MdjikpX8z2vpuyZ/?=
 =?us-ascii?Q?ieqxx2EmB/lSX233mFgR6n9lvmzmchebPuZmqgPfM4BshpaJ3UwpABNddnXQ?=
 =?us-ascii?Q?d1TwsppRnlwdhOiXVYeBRSG5l9/REwj2T1rmWQDkCWibLGICm53I/q2ejQqE?=
 =?us-ascii?Q?dtJwHnPedssah9ppPk7+X2WPPNzTf59LdSTJdZ8fK1P1iVAST1qxE6uOlUt1?=
 =?us-ascii?Q?c02hQ7vaLxiKY20FKntbMLMwI6JEKJn667sIuE3ts13lJSqaI0pRbSPg4exK?=
 =?us-ascii?Q?pqnQvKvafBuJ7DFn4358fA6HlbDPfDkqnfOsHR7eKLBMcDi5E86LzT53ag6C?=
 =?us-ascii?Q?o2XUhNUXi49QfTXbP0GIAlhHdwtil7c2iCJKqa/ZbU1kGEBYZQfvUD9Lbl/5?=
 =?us-ascii?Q?jlrbTKZDMxahfnk7zxaRAQZbY6ccESv4mls7JP0nHjoFcG58E5fHrWFRatmG?=
 =?us-ascii?Q?1smcdaeKO1HElL1tM81/i3pQ3IUy5a64lN+lV08LP5XXNNzX90oc7Kr28JCE?=
 =?us-ascii?Q?bh1LYyukSWKQfrfNiuNnh5u51o33HkYbj/tQLBuO4aJEIj9LYvcEt/VT9dm7?=
 =?us-ascii?Q?RJJYODxNq3y8Ak9fJbnkUmxNU032sHt4LBW7EihYbSeGSWPrwXgTvUNtHud9?=
 =?us-ascii?Q?/XeUycJKY2CpLJZTUSguRPv3kZlbMQFRHqKloTt2tbqO+LuoRO9j+Caj0uGu?=
 =?us-ascii?Q?DQUZ1zTjT4OrVxfHbIqUQ9A336btOhaHWJgn/bkpNERwGXx3FJ4FLkYWuIH/?=
 =?us-ascii?Q?FJqqiAVjW+bsJu3RhAt6wffKQRO/tmUlFr8NI3ynL+wLfi6H9/Ofgy1ZZcbN?=
 =?us-ascii?Q?rLzlxVk6r9wQEtfzwuRmq+Rb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c492a54-356d-4f79-a8a5-08d8e3b23daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:49:54.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMS2Fo6kaHkPg45inX/X3IskIGUc4RCVdVUiRaqnVCsl//INEG0R22x6L4V0rHooGIZS1nuwLKxHByPa4et3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3149
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, March 9, 2021 1:50 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; Michal Simek <michals@xilinx.com>;
> gregkh@linuxfoundation.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; arnd@arndb.de; Manish Narani
> <MNARANI@xilinx.com>; Amit Sunil Dhamne <amitsuni@xilinx.com>; Tejas
> Patel <tejasp@xlnx.xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; chinnikishore369@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>
> Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal=
 fpga
> manager
>=20
> On Thu, Mar 04, 2021 at 12:32:23PM +0530, Nava kishore Manne wrote:
> > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> >
> > This patch adds binding doc for versal fpga manager driver.
>=20
> Why do you need a DT entry for this? Can't the Versal firmware driver
> instantiate the fpga-mgr device?
>=20
This dt entry is need to handle the fpga regions properly for both full and=
 Partial bitstream loading use cases and it cannot be done by Versal firmwa=
re driver instantiate.

Complete firmware DT node example is shown below for your reference.
Example for full FPGA configuration:
fpga-region0 {
	compatible =3D "fpga-region";
	fpga-mgr =3D <&versal_fpga>;
	#address-cells =3D <0x1>;
	#size-cells =3D <0x1>;
};

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible =3D "xlnx,zynqmp-firmware";
		method =3D "smc";
		versal_fpga: fpga {
			compatible =3D "xlnx,versal-fpga";
		};
	};
};

Please correct me if my understanding is wrong...

Regards,
Navakishore.


