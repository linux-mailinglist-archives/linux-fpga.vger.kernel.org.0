Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891F5036BC
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiDPNVe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiDPNVe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:21:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061548390;
        Sat, 16 Apr 2022 06:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoQzQkfF6jAdtiH1Ra3dWRE4FTGsDnLANjD7QJ1DkpDDzA7kCkJPvycG+YBFOjmEx7DbA8kwyCYprVlpEZrRbrftaVFAWAzIjoIM0qfFMDzs+7FOgkQH7R6/JTNE+FDhH1IZxMKSMbhRG6S1En9AkCD8GsKd6YafBgxI/IGdM1eFYGHiyeoRryKNsOIINV/m0cokTOJeTAJl8w2nx31z49m/nTOVDWrFoXQt1AMvP/DWkTuCfRKhVwG2px5kYILszTlmbKB0PXUfeIIp60fR7hlJl/qv9FdvZT4a+hc7d+mLIeuRJuYi/36/SCduNyOEd19JnMe5OLEq4odbcsyGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omw3v7vglyreO+AQJzrFKP9yt2w2kGc0djbA8Nw7k7E=;
 b=AW9ZFsu2BGL94WDRIEYRbcIOCbeviVnGHE52d8fD0nNjdbRXjldljdCkzb3/k9MpCL7okBJEsFKAiva5x8oO2SVuh6/ddiHFHmZg8Xn4uy+mkKPoRTaY10JOhoa91oe8ZGiKBjoT/DCj/H32kXCTgf5XJ9qAXYeD1Y9J6x1dS3zIJ/ZzOm2XuEDsAjPS6If2cM3wbGjqvPT7Wy63X/3K2UX1n8lgP9L5O71xeT5Dep0DsiUCTMyC1hBPdimwEythelrd4pBrArIQDVC9VGZ8Gxs27EdhIN4OhdqB3dtKDwBISyz8X41kQkAqUJT1YPQDj2VVXMZRSE6mUx+NO1RBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omw3v7vglyreO+AQJzrFKP9yt2w2kGc0djbA8Nw7k7E=;
 b=X17QdSJmlcep+/3pM8yeGJyF5AqzFxhMAjsgO+w6nJkb1eD8+K0x7Sh5yY1kJmOylkAA92MViq+21y51zA8/CYF/zpwkehX0rfThDHfS5mGUVMzwOdoXhdxwT0oMJIR/djDj2kufZ/IyhrFalqASusdSfDP6WnJgoIhmT682nis=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BN8PR02MB5827.namprd02.prod.outlook.com (2603:10b6:408:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 13:18:59 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0%7]) with mapi id 15.20.5164.020; Sat, 16 Apr 2022
 13:18:58 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
  description
Thread-Topic: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
  description
Thread-Index: AQHYSkx76o6yFpDLxk2LqWU+DOT2lazylAGw
Date:   Sat, 16 Apr 2022 13:18:58 +0000
Message-ID: <SN6PR02MB45764FB70123E63048963C73C2F19@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-6-nava.manne@xilinx.com>
 <20220405053547.GA249845@yilunxu-OptiPlex-7050>
 <SN6PR02MB45766BEFCA6532873271099FC2E69@SN6PR02MB4576.namprd02.prod.outlook.com>
 <20220407064807.GA256966@yilunxu-OptiPlex-7050>
In-Reply-To: <20220407064807.GA256966@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 369e6d31-cbdd-40c4-0142-08da1fabaa96
x-ms-traffictypediagnostic: BN8PR02MB5827:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN8PR02MB5827FDB3B43B68B6366A7687C2F19@BN8PR02MB5827.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4eFudrEVymXWPliImrZWsqmJ0kkKTWAgNqlAX7VZAVDePFXV9IOEWal/+BxxNkDs/ybvy+V3hcgzJyvuT+uvcB7ZR46D6OH8odx5BJfyhJBsi1hM2zHJJX3/F3iUzO4fq7QnSxqLOC5wfx3yi4qBwlQ7esBlW9UoRUL052Azvz2NRJR9qvrYO05hYmzjC9REO27fswI8xBw/vHdXNK0n846bfOtx5SFagOQ0ALMNvFkjbMnko6pCikDsBk4oT8+lillEf0rIWdzZecYFzip67g026PYJtqktoGM7DosiTuN72l3M+KYvOradB/FfGa0DPCr3B7ErHRBe/GDFpqiVn5LgonqgHCxyLgXePNG03FG4jYTDpkQQcdBdSMbHzGvK2vZPsQYTnboC7UmNN/9/PT1WNGdUXwaPneH1ca+Fcx4nf6/JzL0za1+Ea35GbLhkc1hQhpaE8KibYQlw3SLlg0Jsa1xJO8Zxxl+9WA0bKnzAtFhSMrUEc5fz/4QXcSw4sUGzL3H8zOyW2JCZcwXRLfUIy0MYpuCl8hVAddaI6l6tbbmHMI62oWE6gC/hTtfph/RhXioD5NNa7X6BDqsCqGbMSlVGgOluI719waWDiOyqBewa7JvhTK7OCooxxaacRhgISdGhQK77YaKAKFNN+5Fu/HVbK3Jt8hvFon8WoVD76z6fSiRXyMo4XXJDczme9Cp5q6TANJudSwpd/kzbhxTw80j9kj0xBByPakL8ks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(26005)(186003)(2906002)(86362001)(54906003)(107886003)(6916009)(316002)(7696005)(9686003)(66946007)(76116006)(55016003)(38100700002)(83380400001)(8676002)(66556008)(66446008)(66476007)(64756008)(33656002)(53546011)(4326008)(38070700005)(508600001)(6506007)(5660300002)(122000001)(52536014)(8936002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IEQvucnTHPTIbHUoaS98Tj91Jyz+TfsiBaMj6ZgkE+bkPqsM+bqpy5IP22gD?=
 =?us-ascii?Q?t/no/GpeC0qp4/kCCXBwc2bdBr2DJfkgRWsyZeViV+JgsqsldBAXLZmdApJ2?=
 =?us-ascii?Q?tIm+3O9hzcmUr2AlOU5swpZ7mbsgQoK2qNnKVVNR6T75vqR9opjZdo4kzrzJ?=
 =?us-ascii?Q?skYzK7mmdrQstvplR4ttGAoaTZaIkUDM273fOaCZiwirKf9N6nmucI37kNqr?=
 =?us-ascii?Q?qombTKsiVuxUImvkRfik/xY55PwvxbXEYhm03eV7e6HmH0M9g2g5EJw2Aawg?=
 =?us-ascii?Q?HYwi/CJpLo1u+q+tDcelrVp7Cg5euf2xKy3vx3gvyvRfZmFIqeVy9i2fNUcQ?=
 =?us-ascii?Q?ptFuXqUo+5ki/uNZgv9Z4044E1lidcX94WvlE14ZW2B8IvRqRlB/F/5LH+7D?=
 =?us-ascii?Q?0evk1SULkHoXZNCPiIlkqEeJIkAG+lgduB2SBjsenNxf80q2CwVnZe85/mtU?=
 =?us-ascii?Q?TdMOOTYAQ9xuzBYCeEUgQlPIl3I6NzrUnhoH9nDrN6e+2dXPZDe38lU0SKi7?=
 =?us-ascii?Q?c3RPBypq5rKbcc5aLcYu4XPnirUyKmlKq3jM8yDL3CVZdMMWmPOSDKoL5MK4?=
 =?us-ascii?Q?GRwqMiGJeHkePxqaKBvMzHZVamiZMBTrzDd0UB5siscPCqJpeswPU5FB3Hrf?=
 =?us-ascii?Q?sR3eeku+sKgAwtf0MGGgkd2MjeKcrnmMDDuC1eMt7Fxv4tLWlBIlzfjP9dqf?=
 =?us-ascii?Q?2QMk8RdXmZMXtX6ioznhNPZ6JuC36h6vpgPfjP1+iaeIza2oSn2Uea8ldnl/?=
 =?us-ascii?Q?js/T7qCBMNyFTvxc1ynjLyg0rE96qN07kVhZWAQ9n0V5N5qnNpv0fHZoXNOp?=
 =?us-ascii?Q?Zz4gA/1z7oY5Oh0yFn83h0bJx5p2nM7s9fIHmIDu25xrLBtJvVFmX/reGZ8i?=
 =?us-ascii?Q?UPWqvFZyRRmdvIuLG2qdotARCfvdoOVizkApq0a1Vy8K4lrcmSjQ3vMX1riU?=
 =?us-ascii?Q?o1nZ16QPWBdnW+sJCSa7as7FGI5Db7pi/eMFGsZSy9WrXpYOGAAlFFYpPBNH?=
 =?us-ascii?Q?RTLYLV/EkY6vZYDsJpU9O9+6QS68+a2ZLhqjGUIhn2NHWzTVHrMRh0X6XuU2?=
 =?us-ascii?Q?eNn/pv9rQrGoAuLmRehuDyYmaR6gZzCdyKHeYTlfVTUQbxNocEqEWExb/f2y?=
 =?us-ascii?Q?TO6SR10oN4UUORHs3bJetpg1JqedV4FlvIy8tHVwJlm8pdhjn77e6Ek1HbNt?=
 =?us-ascii?Q?dBuApXvTCICDkuj256BRYqtv1LfF9EsbLEPc9GC/sjKtwOjn2Fpp+JLqY9Uc?=
 =?us-ascii?Q?NFfJvTdq6g6pb4odHMF7gq21Clg17QtNQEpJMLOo+5smMSx9uVvk1MUTmIgF?=
 =?us-ascii?Q?bLGJUShxmAtBm1twyDyg8hY+SAz23/zLEi6sFKg0MawqpMCr5kMEzZZuoqnN?=
 =?us-ascii?Q?iV/i7q/fxok7zlx9zdFSSlzRDPmopgakDEZGKOMtgFgq+dCZYWxBK00z94j5?=
 =?us-ascii?Q?CTM3K+EqvVmTuIEZLLEipWrSHlTsCyAbWY8cAaO8xox1pUeT2Ue4HpfIzPR1?=
 =?us-ascii?Q?sENYhRbQ7Ord1hwRpw3utILh5e8njKzaIMND2p2jf1ZEIdlC7/ZHeVd8JlKW?=
 =?us-ascii?Q?+/zFoCuWeVyTcMXRNJaUdnJYHJIW+b7Xu/nvvcqSsChF+/l459Vqf5XQuHbW?=
 =?us-ascii?Q?HPYQ6W++zgp/9cM910uxlJCXnlIxDolhl/UhTWjEPSRMyMln45qZVmLTo9Sf?=
 =?us-ascii?Q?S13kEOHY2qAJ32jEPVB9JwMZkYsV8Qve8KhqFXiIkhNS2Rvp41otLfEI+koS?=
 =?us-ascii?Q?BDlUT3VR7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369e6d31-cbdd-40c4-0142-08da1fabaa96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 13:18:58.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Bbm568arXSOSz+/+dRAriOm6DsoX0oH4CbGlvaj/V77P5fNzQkAoCih1lUjCiFOGkX6LKLe7PXNjs89snDEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Thursday, April 7, 2022 12:18 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
> description
>=20
> On Thu, Apr 07, 2022 at 05:31:39AM +0000, Nava kishore Manne wrote:
> > Hi Yilun,
> >
> > 	Thanks for providing the review comments.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > Sent: Tuesday, April 5, 2022 11:06 AM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> > > <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> > > <git@xilinx.com>
> > > Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing
> > > kernel-doc description
> > >
> > > On Sun, Apr 03, 2022 at 10:46:41AM +0530, Nava kishore Manne wrote:
> > > > Fixed the warnings: No description found for return value of 'xxx'
> > >
> > > The commit message is not clear. There are descriptions for some
> > > functions, but not in right format.
> > >
> > I agree for some functions has description but not in the right format.
> > The "Description Not exits" and  "Description not in the right format" =
in
> both cases the tool will report the same warning ie; " warnings: No
> description found for return value of 'xxx'"
>=20
> Thanks for the info. It would be better we describe the root cause in com=
mit
> message along with the robot reports.
>=20
> And also change the subject please.
>=20
Will fix
> > This patch address the above warning. So to make it relevant I have add=
ed
> the same in the commit msg.
>=20
> Adding the same commit message may not be a good way, for this case you
> could just combine them into one commit.
>=20
Will fix.

Regards,
Navakishore.

