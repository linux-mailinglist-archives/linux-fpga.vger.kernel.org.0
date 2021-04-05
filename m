Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B710353C7F
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Apr 2021 10:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhDEIrB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 04:47:01 -0400
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:61782
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231979AbhDEIrA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Apr 2021 04:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRH9rEseIK1+6faczTx5gQTrZN2wVNSu+QS2pdcc2rLYBmeuiAcwe9cJtfwxgsi9Bs0WzUK5TmmhUEaWhiLG2MxXIASp6Yau/ezrqQqRxcudF+8nRQ/gAh7VpBifH/DM8oGM1RXlE7Ki7hRRIRBjfAWDr4iVZJ13gv5WhZiyd2LSERaUCNNxCDRJ2JE7ZfMd7yQ1CtAhNzYDHUM5LX4JY20IErquoWzTy5/4HswX55OPSjbZ4WLLOzxEXh9r8G+/G8EKaldZ9vwUL1DUHylWOyUhzHWzN13jusG7YP8uBtRBzdGZNUJ4i6BMz4jJ8+SvJeidgpr0jK9MJw+ZcEfYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCSe7eKn3/UgU4v3eTjdFk9E4b+3yYeazqigB25G4rE=;
 b=LobW1WThZ7PK7CsnTFWoCjUgFcNeCngC+f5rojHbDHzcz2WNuiSUNGuDWjI43sWZt3io3w2WJ2ZteoBy/ZgLtJrIDC+ae40Nl6UL3zVdf7sv8Obcd9mr5hcT8B6lDmnokEkhR9ZuWQWOMmK5TwihZt4ya+XwfvWKuFlyFeb5/5XOCaF4ggPPaceLVhUGQaIU6rMNt0VqtOtIXozwhZKOfRAnIrQNXqTdjDRxM+VKj9KG3nf7x4scInyzPSZQeDKKPPiZYFeGP/l0TCPGm2VF/QzITKYNMM0VqfRarLe82bQTWzh7MovFUJ5ZxZMzhHC1YBQQAymz8Ax7vJib7Xrngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCSe7eKn3/UgU4v3eTjdFk9E4b+3yYeazqigB25G4rE=;
 b=kaar25SQNygJpOwIqb5p9unfDelFDVtY+20rSKvSWix0U+fGp57NUx4T+LD0NFpsFphoEH6SerDu3NtP1QqSjU2WyjUduU2v1vsLQmzEj1KRJKzZ7lXfaMOkJgxonZXsCA9ySFt2tRwPopWkkbWxau6vzQGEAR4akoddacgJmw8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2255.namprd02.prod.outlook.com (2603:10b6:300:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 08:46:52 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 08:46:52 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH 2/3] fpga: region: Add fpga-region property
 'power-domains'
Thread-Topic: [PATCH 2/3] fpga: region: Add fpga-region property
 'power-domains'
Thread-Index: AQHXJ6KbIboogT20lUe4ToWVY3OqHKqheFQAgAQlMfA=
Date:   Mon, 5 Apr 2021 08:46:51 +0000
Message-ID: <MWHPR02MB2623E90AF327BF4416D30729C2779@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-3-nava.manne@xilinx.com> <YGdROrOOzltI/Bbe@epycbox.lan>
In-Reply-To: <YGdROrOOzltI/Bbe@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80d636c0-d990-4310-81e6-08d8f80f5bd2
x-ms-traffictypediagnostic: MWHPR02MB2255:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB22550ABB692E3561DE5172E8C2779@MWHPR02MB2255.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CBYnjuNjvghO1b+qbsPDubiU6cE9B3tapecLJnorVAD0MO87ynASj6xnmVf9EUImtR3ai+Co++XmBZJXGewogR3avlDVEC/TFfutggO5ZMtskgY6mlLWM0gUj78XDGvP5Ic529CoHE00KOTz/3ZoK4Bnpm1dZOLp8CnQMySXo+I5yqJ4sn7nY9Op07iMWPWhSM61RWhw7wYyzJGmg+dkGl9/1vL6tTe5vSyX+rCeDBOzmiOtZgJD3+hHZbic1B112HRl/fo7OM9gnBaN2RaF1KZ020G9YwYpWAFRIL7aJfYeyTtwzvlc+WNsFlf/ITo0OH8wHMhp7jMfwoERQaD8yleYdgiKst3bERYeZ+mOnE/o3UOq8i1briJwKov0AcWTlYfBTqpdw4m5gJrTaVzfVcv1Qv7Qa6FlT2ikid9ar9ubUUEhOJMxiqH3s8S68sJewAiDr8sP4MXOA1xy/Vtw68UTzj2Qt7sDYem/8d7x7AxUYi75L0vZ0lrUPySDcP9/Ry40V0Oy/+ufC2kiykidFVQ/n37YTFS6WBIcgKvfMrOOJl0xVHAa5cd4WQzfFf4gGH11s3KQspFy4KkZgYYhZMXZV9wWNolYCsX0jWi+Bq0HxJZF5WIcfJkVLSOWDq+aJ9GusjZxzIAPRUavBBjd7Yh4Ko6X8netMq0kVyOtsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(366004)(346002)(136003)(4326008)(76116006)(6506007)(316002)(71200400001)(55016002)(8676002)(6916009)(66476007)(478600001)(66946007)(53546011)(26005)(38100700001)(52536014)(2906002)(7696005)(8936002)(54906003)(33656002)(186003)(107886003)(5660300002)(66556008)(83380400001)(9686003)(64756008)(66446008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MJHb37kC552iz2MIP9N984phK8W2gpQtkMD+Td+lcHxSDJu1qkrOrnW1mGT8?=
 =?us-ascii?Q?99RlqifjTAgOqCIeWKvoESvwsHtplX3Byt0qcWAxz61mKfEzAnAS60IXMcFe?=
 =?us-ascii?Q?jRi/lYU+Sk32TgG+LH5/bIeWRWDwYaT36F19+05e8w9iaqmVGupJs1ohuu3X?=
 =?us-ascii?Q?HqIWYt+imjg4mfxvaDd4xeqXBkJq86rw+VFtE5NeaZNDdxJm6VZGY9rN/y+s?=
 =?us-ascii?Q?3JidBGnC9fJS9I31D4HFH0YN7Xzu0CRZW8rmEtxdYuB4YQDrYteaLL4oKhSu?=
 =?us-ascii?Q?ExO3euB+xjdp777AK0jEEIl3ahZJhoVLkT3QmrCsRL2L4its9s9DDJDPrMfO?=
 =?us-ascii?Q?lYzF1pP6Z3V5twIfX3Mv+MMcnichS2RAKgD29uJu5tNrIIVJPB4DAEbiSwaG?=
 =?us-ascii?Q?Xzr7e64ADubKc3MMpkKPG7cpAenkvasZdJfxAzkRX5aqzozOil49M+caXbiW?=
 =?us-ascii?Q?eUFO/oHIbP1yOSD/XOhCnr2FMZWdSrjJlC/Mt7AOg4qhsCy+HaQBhwoKyZF1?=
 =?us-ascii?Q?mJtmvJAMjmZcWmMNxdFQFL/BRTD5UNUvtg+d0GbAoWJR91p/y8JKvav27k7l?=
 =?us-ascii?Q?Cz0DeZpEET5kR0ID3KygpfCotxfaSdDjlxSW20IzdUbwaSSQs1sZGClm1l0n?=
 =?us-ascii?Q?VIxzB9aBIYw8LlIYM+G97BBPhwE/p9QQ7FP9XfsuMTK9AqSPtlW7HDREWisO?=
 =?us-ascii?Q?nU23ihbmyCEtDo60OomjtMMxaMbjzrZ3oIC4dv+oMkULxxQcTl3hsrWsRTbE?=
 =?us-ascii?Q?KO0NNBhjImI+RVxRDdm/pA6S3xCTjrrmjGABxooJI4W4DO43y9mc9WAb5lPS?=
 =?us-ascii?Q?u4gLCCOw9vrskVjUCNohhmilzHMEsjTsaE1R6YDs4/QbmFMLFCnw7Wr0IbYZ?=
 =?us-ascii?Q?SxPipZ2QTXfLN05gXGR7e3dGHZ5a6BBzrnU9FhfVbnrBY1wxajj9xFN4xcZa?=
 =?us-ascii?Q?j13UmuQyjL0a233DyTSbJx+r60oFSnQVwt8aNCfzfWrdNvGdjFcPO0LhtfCE?=
 =?us-ascii?Q?2wk5gv6npueNQxPUAi55B0fXf4iHr8LmpHLKqOO8eeaFRerz/4EJJe4elNO3?=
 =?us-ascii?Q?MC73xFvekPd52Ua1STdWqNvYILXyHcfI7J3UZKMh50RQtRI25wxhXThJSq+s?=
 =?us-ascii?Q?r44YAeTXglv3phHu6AQoZSDC00y1kACpdpL6J9TZic6NefiS4osT+ZDsIsvU?=
 =?us-ascii?Q?7RkH9KQeQNdKJfgZFnQONhAxBPZzoFhmcympxeScwzJTEsPgDV9s+kxIkrq8?=
 =?us-ascii?Q?xtnMvPI4/6lNXbe1am60MdXFi6WEOjRm+7uFhinOxbRsQ6wjWusavIM+m819?=
 =?us-ascii?Q?CeJqnxHr7mCVufteSwElZLA0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d636c0-d990-4310-81e6-08d8f80f5bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 08:46:51.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvF1KVWJOSWp9sy3o3OzMNUBuS3o3cL1lotSsfbVJ4pJOR1T5TdXOB3zWLcgTMpZP1mTfNHtZNUbqPz7k8JjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2255
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Thanks for the response.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Friday, April 2, 2021 10:46 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: Re: [PATCH 2/3] fpga: region: Add fpga-region property 'power-
> domains'
>=20
> On Fri, Apr 02, 2021 at 02:50:48PM +0530, Nava kishore Manne wrote:
> > Add fpga-region property 'power-domains' to allow to handle the
> > FPGA/PL power domins.
> >
> > dt-bindings: fpga: Enable PM generic domain support
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > index e811cf825019..969ca53bb65e 100644
> > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > @@ -196,6 +196,20 @@ Optional properties:
> >  - config-complete-timeout-us : The maximum time in microseconds time
> for the
> >  	FPGA to go to operating mode after the region has been
> programmed.
> >  - child nodes : devices in the FPGA after programming.
> > +- power-domains : A phandle and PM domain specifier as defined by
> bindings of
> > +	the power controller specified by phandle.
> > +Example:
> > +	fpga_full: fpga-full {
> > +                compatible =3D "fpga-region";
> > +                fpga-mgr =3D <&zynqmp_pcap>;
> > +                #address-cells =3D <2>;
> > +                #size-cells =3D <2>;
> > +                ranges;
> > +                power-domains =3D <&zynqmp_firmware PL_PD>;
> > +        };
> > +
> > +	The PL_PD power domain will be turned on before loading the
> > +bitstream and turned off while removing/unloading the bitstream using
> overlays.
>=20
> Can multiple regions share a power-domain or is this specific to full fpg=
a
> reconfiguration?
>=20

These are generic changes and not limited to full region. If H/W supports i=
ndividual power domains to control the Partial reconfiguration regions we c=
an control the individual Partial reconfiguration region power domains as w=
ell.

Regards,
Navakishore.
