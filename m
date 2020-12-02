Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA952CC60D
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLBS6H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 13:58:07 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:13600
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgLBS6G (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 13:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVBGeMb2PdC6V2kxdhPt6TO/xk4Akwa8IMtB+5+k22rbKEcmdJtoZbcGaxpKlTlIXuTcz07lHl8h17ark0VAbExxiZ2AEd+lzlemdgEZfPHQhEShUZpsomiHxyaXtMIi6eJGKi0Qw5SdldWduMqTNyjgqCzFZsXijCJuDh/Q0WNTkkttL7tOdvdqfPktLyGc6S+3MZlCDOpW8AhNs5A9tkwHbtk0fjonAwkc/TRJ1oIFDX6Rt9SjJdwLOBwhQ1cAV4FMxn9XVyP1m/LMw3vuycoG+YREvtgaJbyJJZNr2+HmcKexAuPmggp3NxrLpEwRVnD4hhEeG/ML17u7Qelz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZKtzSPcU3bsCivNCPBSZvkHhSojWtaTswUk+FfSzBk=;
 b=AnjSyntPgqlox4bsYKfmLkcMHszZ7slEy23/0McikAlFHZPnKQOnX8E3qSJDfSJLLzFRgVj92xTwUehgI/qTevEM7DYrfj5TY5OwC7JwPaGDReMWxqRW+OrTeCcX9myADKj6xSVo/siQFzRXRr4VmsuGWU8xPfwdQ5mw473gE06WGP70Fj0rojQM/oqJCQ1C5w9YFGxNJihsbB+iqperBn9PP31ML9cSzM4+hVAT8bUcJUpubjvnj3rVHyqpr4A616RF2RUJ+LUdVwM+mEJ3RAzKy1V5HMrCpqOgH0KIaQD6TDtLZc9LFy2YolwXo9eHaZo7EOrMmj7HnBikkzTqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZKtzSPcU3bsCivNCPBSZvkHhSojWtaTswUk+FfSzBk=;
 b=RE7BpqMbpueS4selrzAPOHpRQrbw1W71sgKTaDvj+eduF6qddoUuxFEU7TYZrFzT/aD1ecsR0MBmu/dG9gbdJIlpWiK2SNN0EhRE1kfp19lFUQEGGknCoIsNELMYYTx71mgePD4apZDzkIC9C0dKrWMxwSF5+uCl2nfZbURHLps=
Received: from BY5PR02MB6260.namprd02.prod.outlook.com (2603:10b6:a03:1b0::29)
 by BYAPR02MB4839.namprd02.prod.outlook.com (2603:10b6:a03:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Wed, 2 Dec
 2020 18:57:11 +0000
Received: from BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5]) by BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 18:57:11 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
Thread-Topic: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
Thread-Index: AQHWxeLgPKk468uu20KtHlzY5ljvuKnhqLiAgAKC/kA=
Date:   Wed, 2 Dec 2020 18:57:11 +0000
Message-ID: <BY5PR02MB6260A727613D2D8A447B1D26BBF30@BY5PR02MB6260.namprd02.prod.outlook.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-3-sonals@xilinx.com> <X8XGI7yRAX+xAeqQ@archbook>
In-Reply-To: <X8XGI7yRAX+xAeqQ@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [98.207.149.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49454620-7e40-49f6-e853-08d896f4138c
x-ms-traffictypediagnostic: BYAPR02MB4839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB48391AAF03D4AD0B08D8B6FEBBF30@BYAPR02MB4839.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COnIFCM5RJRkj+ejyln5tO0FtIHyMMrv4JocydTRK4X+CYoeQwhGAJMorOOgYAIrdRyglE+A/kY2hJO/a0lIA1cVy3ojEalHjZFWTfgxhFi0ODVvjzLERmVWW47x+LNlzaIsZHmT5qa5hAJkw5Ch2PJu1Tz9PV71qd/eONtSevaQea1eCyTScdmkeCBXNcZ2wtcdgmyT/+TKl8mupBOBoQ80zwmNIbRMnzIqbmtJq2bEa/ESbN9E++hskO3bx3G3kqN2ZruRDKNU5KKrjWnzJXEuQl5Gkcf10ukjLkmqmTjpaoPU+1EitjVMlSLesNMiWGoOsUg0lHOQ+IMLi0w3vuya9s5ckOsY+7hlkK2LsbGc8K4jNXYRYtpTVKdAlX6F0ipThEUCXIEQar8V4XhwQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6260.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(83380400001)(6506007)(53546011)(2906002)(66446008)(66946007)(66556008)(71200400001)(64756008)(76116006)(66476007)(55016002)(186003)(4326008)(9686003)(86362001)(52536014)(26005)(966005)(54906003)(33656002)(6916009)(8936002)(316002)(5660300002)(7696005)(478600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IzfPnt3TEKrGF978p3LAfpFVAY4x/8j0E3Yrv2/VzbeEVfWYsOLyBixO+3Nz?=
 =?us-ascii?Q?zDDmqh448tNzVFkOtAFjnX4wOwsoARZ3HoaI2UhxMyiuFOWnCgLvs6rBbeIc?=
 =?us-ascii?Q?YprbQpAbHLheBRUhtSPf4cZ768QUKaBUHY2/Cp3SsGqLpNWaya+QkPkfMz1+?=
 =?us-ascii?Q?f0oHzR99qvrGEsE36jFtPafKwKUZkxecLSMre6g95L4RS6cpBiWzHtiCYloN?=
 =?us-ascii?Q?L6r9/JyLXsKtPHca2oQVkRwlqK++L5epuQ/rFzxkWeOb6g3kOKsLkeXhKyfn?=
 =?us-ascii?Q?ERfnGBIWJVjHw5bEWiqGDEiKUQf6x2oSjuVveEd6UfA3zYyca2O8MOOdRgQN?=
 =?us-ascii?Q?WwXRPMEkuf2jLMVLkxphBHOVFQBOf0C88Ww3DcJh6n4VIx8D3V0QgmMsBlkC?=
 =?us-ascii?Q?XQyexdxFbe41DzOGKPIfy/yr2/xxXXZgkUGgMkwCEhuN0SE1pK5zHaDoqEVF?=
 =?us-ascii?Q?LaYFyAF/VjPDki0QAHaC9hhsO2Y40+6FpFtFsKT7aFru8MA/atypx/DLYd+C?=
 =?us-ascii?Q?oSrswCjZgMvU+qtm+QLCC8ajchui0todFOmZxO14aZWOOatOElA42hg0iYNF?=
 =?us-ascii?Q?6D/Xc2Gc+IwLLW1NSy+1fms8PAJKlm2rNCcCVq4Q0902HRGZ9n+QqOS5Owft?=
 =?us-ascii?Q?EQXRoUgNj1B2gQTpO+5SFuXXG3JHsUGGiVmVBtAAQOpFZ5xftMiC4GT7KUFB?=
 =?us-ascii?Q?urHg9+QdbqACRcL/yTi9CjaZO8RG3yGzMXuZqIdKKSWFVxez61/szAf++IzM?=
 =?us-ascii?Q?9jtT/Rvc3CUXNy50nAk7J3QzaVZauB3MtyMWVPbU38ygko7BlDsQkR7NPvuW?=
 =?us-ascii?Q?7Ts5oBah5WDfAGnElBPwPYvSUcQzPvs4plEezYMCUlDgA9wObkVbLqNy5XN1?=
 =?us-ascii?Q?i6PPnf+E6wJsxIM4kBeN6EZre1GtvWG8QZKGUnwMZB3zS7NdUuG7NK48vU5P?=
 =?us-ascii?Q?od0RA4njqRmjsLNy1aj2I43C8iUYKj3jHXLRdWhZVVI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6260.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49454620-7e40-49f6-e853-08d896f4138c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 18:57:11.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/rMA3iVkhjl45AlcVDT0lHdJKqJs7I9Vy4GdrbNafsDEPyMitSMjWMboWSYwZ0TpKL2OnwlCE4JZzxHadCI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4839
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Monday, November 30, 2020 8:27 PM
> To: Sonal Santan <sonals@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen
> <maxz@xilinx.com>; Lizhi Hou <lizhih@xilinx.com>; Michal Simek
> <michals@xilinx.com>; Stefano Stabellini <stefanos@xilinx.com>;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
>=20
> Hi Sonal,
>=20
> On Sat, Nov 28, 2020 at 04:00:34PM -0800, Sonal Santan wrote:
> > From: Sonal Santan <sonal.santan@xilinx.com>
> >
> > Add XRT UAPI header files which describe flash layout, XRT mailbox
> > protocol, xclBin/axlf FPGA image container format and XRT management
> > physical function driver ioctl interfaces.
> >
> > flash_xrt_data.h:
> > Layout used by XRT to store private data on flash.
> >
> > mailbox_proto.h:
> > Mailbox opcodes and high level data structures representing various
> > kinds of information like sensors, clock, etc.
> >
> > mailbox_transport.h:
> > Transport protocol used by mailbox.
> >
> > xclbin.h:
> > Container format used to store compiled FPGA image which includes
> > bitstream and metadata.
>=20
> Can these headers be introduced together with the code that uses them as
> logical change?
>=20
> I haven't looked too closely, but it helps reviewing if you can break it =
into
> smaller pieces that can stand by themselves.
>=20

These UAPI header files are used by multiple source files hence I wanted to=
 get=20
these reviewed separately. However if this is getting in the way, in the ne=
xt=20
version of the patch series I would look into arranging the files different=
ly.

You can browse the changes here as well--
https://github.com/Xilinx/linux-xoclv2/tree/xrtv2-A

Thanks,
-Sonal

> Thanks,
> Moritz
