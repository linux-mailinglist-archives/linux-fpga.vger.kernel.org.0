Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBB37282C
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhEDJoa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 05:44:30 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:35356
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229953AbhEDJoa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 05:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHu76QdX0WGnriRGsYKRQ7xHaez3oJ/WqCDI3J98GhQQL2KMzr6n6+P1cDRaw7iRao+d4QEVgskS8szIsSwLK8bffdx6t+wCAsbc4hYk2aTGeFuoh9LFfEoVJdl1xqp1MrXNILmntYIByvEFTKxkAScn8FEk5QbpcOsPwSnk9s1c3Xi/gMsracxa/GEyuzxoGXPeaOnw0u7wzkhs6d3JIa99qsu1PwCxJO3Z1WaqMRX0G8gOhfBohmEy+K/docjb6HRoUoAoXndax3ebuI325+wmQHYpClmF06sUAr2Lp2MvmJC06CSighi4khkV/c2QBPTjCBtqecmdKMLFwMynIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrmJQHp7kbYwR2ISlE5/XS2BNEjOxpyzHJb0SeRenG4=;
 b=HVvjXMaxAtgr2S4a153XMhsmvtB/6y1/XnHk67gk8XcZcobSwVi8UrWd+a0rqvEpxwe7ssshldRBzNdh673Qx48smekHOsn9X1SSgvScPtUy9YIU1Tc+I9c1JjHFMBuZmB76dgvnC/M/4U2XI/eJVEau3996XhNmlghsauyDc4D43B56ExzqMQsPwk3JnTogd3D9q7BadKG3z7wnGaAYEfMBetyRtu7vFLvjPZlb2v5TVrJZjWAGlUST5gAtOkZaDDYVuTUjKkJPU3YC/dsE2crBsOJ5c7cmgJwImuEsSeg6de9OXbFPyK5TQfHjdeNtY5K4vIWjRuNkIdv5PCbIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrmJQHp7kbYwR2ISlE5/XS2BNEjOxpyzHJb0SeRenG4=;
 b=N0sZq0p/1xYDvpLGCAbKDQnhUNiO5jpMRsdb5SSG3W8n/GVV6JqDukqfQFu5InDHBsuA2YyNYLY5terBQlg6pSLnRqndDPJt4rEXtvRu183y052drsdWR9p3blC3shVvuV/Lsrtllg1GbdjdXtWmZz4QMjufytUV1j1nVEFffaw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR0201MB3563.namprd02.prod.outlook.com (2603:10b6:301:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Tue, 4 May
 2021 09:43:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 09:43:33 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Topic: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgEAJlgCAQnFyEIAeHL7A
Date:   Tue, 4 May 2021 09:43:32 +0000
Message-ID: <MWHPR02MB2623AFF01ED009D47DDD95FDC25A9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook> <YEAXxuU2J1yaAl3U@archbook>
 <MWHPR02MB262373853A19250FDFB7CEE9C24D9@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB262373853A19250FDFB7CEE9C24D9@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.206.49.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56876738-4e07-488e-a028-08d90ee114fe
x-ms-traffictypediagnostic: MWHPR0201MB3563:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB3563126A97942427F0CA2571C25A9@MWHPR0201MB3563.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4TkWInBe4xSNlRJ0YSgFMZAz9Zn8nG+j9RhkFwPanVcfhvPTURfOYgT80ouQpi5T7pCMElYF243K84egJuKQ46hC7+ULafCEiSDHeMI2QwT8e56Y4sDIU7+ttYJxmLyxJK8RPzsfB97XeruhbvGsZDEQt4oCHgj2qi0UVxllG5H7ArZ6E6oTQ/buGBVAH1WLbDkdnr3m/OOtjFrmenbuKBMmnxjmXlbzIq2FuFZi+1BhsZUE22orbBY9RkRSg+69JzofqIitql6JPHKDcA7Ho7OzNOX/Ycgk4VTY5hrPM0CodKxXj/940PsK2KzgmnKTfTs8qNI/hdO5qVEl2eypIIngLzFq7ClPF1oM0ZET3g8u0hbjTfAxc+LxOPpE0idY4atS0m+emKL42DhDaLx8oWJLjSnsDUgLUBkAfjDAcnvMqO9mIIjc7lyHQhVNuXpSsRnj7/I1+/UKUgTyCQ4rXbkkRxFO4mS85jEQn7VFDgy8Mt/WgvW6h5yokqUIGfRR9YNXxH0d7HCI51ujDXaRYb2tK38MCzjI2owwpqKnEbiisY5mtNbxPxiLAixsy44VXx3q67xL8qyBZgxg8VdrMkLGq4HUHRw5FHhuotdSzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(8676002)(186003)(8936002)(66556008)(33656002)(66476007)(6506007)(52536014)(7696005)(53546011)(76116006)(71200400001)(66946007)(26005)(4326008)(6916009)(54906003)(2906002)(5660300002)(55236004)(55016002)(478600001)(64756008)(9686003)(38100700002)(86362001)(83380400001)(122000001)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8cjbXgVd5F+MSWaGS4L5GiRSsF+OgYDNCJR63m9x1OXrTLFhQM3mr6xkt6eF?=
 =?us-ascii?Q?E7dbVLEK28O0Fd3Xji+zVMZ/JrKA76+YniwMeCdMcj997ejObGtK6cGFUTuT?=
 =?us-ascii?Q?+1htPkNp126wgbm+1T89HCSOSQEsFSnHQG37DgWjNUF8BJeLam1ZviTtg3IS?=
 =?us-ascii?Q?LXeHgqERhJUmGRpgYjOkWScE/1KdBFgBBCBvchCidP9phWJ3Tg/GgtVmuj4b?=
 =?us-ascii?Q?eOSjZuRd2Smhy+B2h3zXcO5+65mNDb5JKOpZoo7Q9etWf/gba22deqHP7KFX?=
 =?us-ascii?Q?c/ynTg/4qHDJQPFyXUBKm9P1iITk0LO555kYjYXKh/alenl+PQISWoNbwyVv?=
 =?us-ascii?Q?++VxVwd1KdFscIkIRLl3DcmwfvvZkrIwpd8Xwsa6lRRpWK5wBiYFdS8ogFx0?=
 =?us-ascii?Q?Svz3ejhEMrVgqDTRsK0eeAb9tiF3gcn5C8GboGUTbtC8fl7oTgBrprf5i2id?=
 =?us-ascii?Q?f3uUQXGe3mXYKTFVZ9xkI+r573hmW2owo+8ipAtmSuqTeZBRD75Jn6FIG2CZ?=
 =?us-ascii?Q?yuNaxsby7sHq8p/mnZfZ78yq942LPJPZK81f8yeGVbS8HE4Al3uwAREBAzVP?=
 =?us-ascii?Q?+d9vZsD+uxF4rzyi9idsce/RIaf8tKBHqMdQ1U41/e7SAy2Miz1l48nceX1E?=
 =?us-ascii?Q?4H8vicSezFif/TRW5bpG2n7WSWdaMhR/2+giWcfkT9IU99KEefQ8Brfm5oWz?=
 =?us-ascii?Q?8S6cEWhTS0M0GORWZaMoCa26b54khfttJOj76ohVPm/zRj/XHeNTeMQwCANF?=
 =?us-ascii?Q?C5xOhip52EoDqT6tpqyhL6q4eeLBy/RyId8w0l9bScUdCs4DtvrlErU9Jp8/?=
 =?us-ascii?Q?R4k92RZrMA4aD3kc4BMF07hzluT5GEa9eZlSKcu6QjOBRiAejxD5zpPyUpCE?=
 =?us-ascii?Q?5+ctt6bKx9w1h0Ym3CP4WS57VxUVCPvYTgAOIjVeJd0lEQUIccYxIM4C3N1b?=
 =?us-ascii?Q?5xRMdvrqLLr2Ni7Sxr83VqTAU1aI2B2f4G/Bd6G6UNS+BH1f6VUsEpr015qb?=
 =?us-ascii?Q?CpqOXaaalq4OBxctR3qTU58tvClYJgnB/kvfRuGhp/4HvpWcOGNlddSSW/LS?=
 =?us-ascii?Q?2Z8qTKda/FAYWjb/8gmKyGg50ypHYC7eMTkl4lTozSJlS40E8VuYwK+Zs0fW?=
 =?us-ascii?Q?RCa31DLyF3SEdO00cQN7cc5nHHZxgP4in9xc5SucS0JdHateUmQQQr4Ww1A9?=
 =?us-ascii?Q?ZN6454SCxNMNIEWs05ESNraRz9O5wJzRD7bjh7A7P4jWBeap/9x/VVYAENPj?=
 =?us-ascii?Q?JxvY9jxqCbvejtAhzkiDZSXjQg771zv2uvropxL2k7hp6kDT/7YYpMbHcZP0?=
 =?us-ascii?Q?0QrKSaD4DPB/VL+BpmxDwSoh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56876738-4e07-488e-a028-08d90ee114fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 09:43:33.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S55YWNSjnUsdoi6SwbMu/5z5tisVgI31yGOlFQkkv29NdEtNnBS7SgSI+q2MmUW4iBAmp6U3YFTftRhy1OX0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3563
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <navam@xilinx.com>
> Sent: Thursday, April 15, 2021 11:28 AM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> Hi Moritz,
>=20
> 	Thanks for providing the review comments.
> Please find my response inline.
>=20
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Thursday, March 4, 2021 4:42 AM
> > To: Moritz Fischer <mdf@kernel.org>
> > Cc: Nava kishore Manne <navam@xilinx.com>; trix@redhat.com;
> > robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> > <git@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > support
> >
> > Hi Nava,
> >
> > On Thu, Jan 21, 2021 at 09:17:10PM -0800, Moritz Fischer wrote:
> > > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > > > This commit adds secure flags to the framework to support secure
> > > > BitStream Loading.
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/fpga/of-fpga-region.c
> > > > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > > > 100644
> > > > --- a/drivers/fpga/of-fpga-region.c
> > > > +++ b/drivers/fpga/of-fpga-region.c
> > > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > *of_fpga_region_parse_ov(
> > > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > > >
> > > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> > config"))
> > > > +		info->flags |=3D
> > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> > >
> > > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > > > +
> > > > +	if (of_property_read_bool(overlay, "ddrmem-authenticated-fpga-
> > config"))
> > > > +		info->flags |=3D FPGA_MGR_DDR_MEM_AUTH_BITSTREAM;
> > > > +
> > > > +	if (of_property_read_bool(overlay,
> > > > +				  "securemem-authenticated-fpga-config"))
> > > > +		info->flags |=3D FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM;
> > Shouldn't all these get binding docs? I remember Richard adding
> > authentication support for an Intel platform, too and I'd like to
> > avoid adding random bindings per vendor.
> >
> > Would it be possible to have an 'authentication method / type' that is
> > more extensible with different methods maybe?
> >
> Yes, I agree this flags should not be a vendor specific we should make it=
 as
> generic.
> can we have flags something like below .
> 1) authenticated-fpga-config --> By default it uses kernel memory(DDR) to
> authenticate the image(FPGA_MGR_MEM_AUTH_BITSTREAM)
> 2) authenticated-onchip-fpga-config --> It uses the On chip memory to
> authenticate the image ( FPGA_MGR_AUTH_ON_CHIP_BITSTREAM)
>=20
> if you have any other thoughts let me know will try to adopt the same...
>=20
>=20
> Regards,
> Navakishore.
