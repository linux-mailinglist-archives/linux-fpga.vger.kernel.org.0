Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010473C20DD
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhGIIgi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 04:36:38 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:4566
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231494AbhGIIgh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Jul 2021 04:36:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utl8VH0CkzzUvycC1rqdrGQMqhyBaa102NykAnC1JFVZ+RpoHrFERMpXD8Wm1hUQ8V1eAMm8wOm73+DULAtWMK+Mom15kVWOuNCsbfsqlxiC/taOlf8R+knJ0Fv6f/n3IfRQgHgNE+i+d8q1IxSIDjOsFXlFvFSPruiRh0OnfZ9WSHXjRpi05TfGNLdEYSmKSpIaGr6N1WHpf8Pb4wsBiSexsV5ugq9jvi6bIUFlKcrmDaxVYhXOy3O9jLjg25Wd8njsIztayVt9M8XGr/bk7sOw9VWuxJ+NhVXQIqerYcRK8EW/NLjIs7mzZBY+WjOaiRde92kciIWzPQV6fYYdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEVmd8g4dCsCNcs9qcxkgDbw5kQwfeB+kfNQi9D/9hs=;
 b=Lzi8tdBg09aNTB24MYqBja5t5UvqYJVgmc81yR4GALtUGzQ3bJHV9zx+ywH1lMGKNoZyBnByyTl0IFd0NaO9FAnoga/NZ8fkH0vZ06V4KpqDKmz7O5Gp284R6Yku+ZqJBUHN0QHvQT+et9Om+7o4z33myVinGSiS44HtKYqvCRfYXY+iIvePrQe7LatcNVaEz2lb8NexTisLeoDGIjjF0/QrS2DDbXYSEGe10qI2DPE6tNEJ7wC3WP1yURZWg2fY0IoD2HthD5Pc1Rt6gHAM8Au5lgvq8QiRmUnoTh0jEx7/WpY4FbTUT99L6JDMInVKegRmraIbwo1DqwXxBNznRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEVmd8g4dCsCNcs9qcxkgDbw5kQwfeB+kfNQi9D/9hs=;
 b=lkRV3Nrpp8+oNjU4F4Z7eu9LqFe4yxfjk2D2y9nMWOJWdOp3FPRVrgh3TtKCWBzSS7xLFy1Zuhbevx6tNAi3dDONt49BcnSCLY657Lhq9HAO1JsQGHTWEBQ4SlanBUa3dGS0ZlrA3N4fDNG+ucg2+MV7l7HsturKUl0/w8GDrhk=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB8616.namprd02.prod.outlook.com (2603:10b6:510:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 9 Jul
 2021 08:33:49 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:33:49 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <ravipate@xlnx.xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [RFC v2 0/4]Fpga: adds support to load the user-key encrypted
 FPGA Image loading
Thread-Topic: [RFC v2 0/4]Fpga: adds support to load the user-key encrypted
 FPGA Image loading
Thread-Index: AQHXXPOugeyV41oUbUyELuYcyX+oKqsLcUCAgC8N3bA=
Date:   Fri, 9 Jul 2021 08:33:49 +0000
Message-ID: <PH0PR02MB73367186A920B6DB0028442AC2189@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <YMCQESaESBSKCTrv@kroah.com>
In-Reply-To: <YMCQESaESBSKCTrv@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afed79fc-9b8c-4d72-de82-08d942b446a1
x-ms-traffictypediagnostic: PH0PR02MB8616:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB8616BD47167BCFA29E64F2C6C2189@PH0PR02MB8616.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqJHYHotSxMBSnV1t+gpihLs6XfoiUf3WoH9yh0bsHeLVAjZFPQfK147VXYuuqQNDuA8MiRABOQhNI6045PCI5zSHBRrE52390Z8IXC0JRHPT8JU8QoMgELdmqc2sUbJqm1dmDZK6iPMxkSHbGe3Vgvnmd8758xXz2fx3fsZQTXE/P0vTuft0EJzFwvHxQTkEchULktL8TgbbWRbRUsYkK7yMa7bHeZdzCC8kRgO2bx8HRcKVtZus7t2ivgTU2PExCRDuevKpZa3sZOmfSq+oVZkM9uGIG70sEq8eaa3AGVqxt0gpaGZxn65My6GatXRIUliwotAVSUnGHoOzxw1+Nq26+HNUN+nJdi7YLqTziWSKQcSMooMHGifhhdHwSsU76du5hLqLOCuQ4pHYAVaH370KXtS2yZxwfzT4ZIG+r5kVV/yQKWqJqnFMS7swFrZTrg0VWZN9Qqb5ZmdbF8uEU2t8oryy8mk3DJoKG8uu8U8UBF+3RSD0rfIgDWlfYmeLbcdj9diHLuKI4JY2sooEMazkrTMK7IQZLIcTy5xmQfZ1fLyORToxlSmtCVHXK3YEql3u04WBva3Y67vm9gfwSlRyGtx0ptXPuKreOfTK/9xWshcUZrWur9FE/4OreLG/gZ0JYcNNVeatKuQCChRUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(66476007)(55236004)(76116006)(8936002)(55016002)(7696005)(8676002)(186003)(9686003)(52536014)(71200400001)(66946007)(38100700002)(7416002)(64756008)(66556008)(66446008)(33656002)(478600001)(2906002)(54906003)(6916009)(26005)(53546011)(4326008)(6506007)(5660300002)(316002)(83380400001)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BinEKWUJ9asOCVN9PRBgmS3PP6s6kMENcuaOHweRWaDxllN2Yt1kvOVQSk6j?=
 =?us-ascii?Q?VI7i+h+Xt5p76YVZrLLVQIYoz3YB+EW98l4d/ZbETePUww7gumdW3LeqV0d+?=
 =?us-ascii?Q?PgFkxPsRYdfNhUX5XLiH407N7diADBmEl2uzfT4s51YWD7qImhRfEVsexjVL?=
 =?us-ascii?Q?uK0ztN4tRhuR0qJ/M8JI+A3hX6M28CEp0XDrOB4ddM+IKzEVrrMBtNvhVWg9?=
 =?us-ascii?Q?BJ9rmL37sI9Xb6Vxo8ZByrwbeTCnKquZLWN5AeTGqzzNygJLPV6Ecm1UrjM3?=
 =?us-ascii?Q?FQeQix4+UKZVYubNMxnNY2JfRQNRz7JMZp/ZmRc6JlWz+w0OnApWmprHH3qH?=
 =?us-ascii?Q?B0FMmrLnOsj+U1syUAaaV+Us3l+rsLo55Ue1E6/jke2tiEp6qbs+DV/ye0iw?=
 =?us-ascii?Q?Ys3pbct9RkmtMVr62U7WHL7gIzCgKUo1cY9XXXFJdcMZmJN/F0lRwA2TxD0R?=
 =?us-ascii?Q?UoTe8R/VNupUgFuRTx5604AFh38OYbEWupTRWjm+wf3PKCHn3pIt/V8v43Wi?=
 =?us-ascii?Q?zR8AiqbP5p2Z3OisYj6hGWExg8ft+4PrlJo9aUHBw941zRa3zJPwjo6Fj+Va?=
 =?us-ascii?Q?Ig4N2XSji+HlpivUIU06tV/YmfPuC1cxTA2dGXg2hrozSaNG0CDww8K6To0b?=
 =?us-ascii?Q?BEcQKpgb6ovej6kPLyaexBXYlWK8bIC1T7htpU5PzUDE1+xroULmVgATYA/r?=
 =?us-ascii?Q?UzbxDwQwBpCr5wj7uWpj1i2cNkDgEWSxvcy8r2MuiyfyiLiikyJ91ocwITrG?=
 =?us-ascii?Q?Ue+sW60qghxrW1Q9apb72o1M51avmDbVdIeAO9n/Ewx3UsLhQx1D100i+XNp?=
 =?us-ascii?Q?FCUpRi1PEMveSbQztFzobmOoUE9PLwb/fs7f665Gy7OzSp+vrcbbZxF/0kGY?=
 =?us-ascii?Q?ZHvw5S1KKlYVpAKTiYG+DpuECPVE9I1DearV1hY+8Y3lqZ0ESU4dXCcERrCD?=
 =?us-ascii?Q?XxKyLa6QIc8DOH+j6Hty1DafPeL0LeNwJ3WZRMcLzALGDHekGBZFU9qtKUbJ?=
 =?us-ascii?Q?NMCpB5w79+MmxmzNPD3iYydgO1SUKFWKlRn9mlTR5T04oroqyQTrImGhsY41?=
 =?us-ascii?Q?EoQ+B3m1Dxy0/fSKNFl6C7hELfbAMvx3QTK20gR+6ZnheA4FbsmA3EO05NMZ?=
 =?us-ascii?Q?aIVcfIUq4ZzN+HWIi739p8NzXAjRAmXxBUwJJ8HdYjdDoHPBUHoHjUSVKUoB?=
 =?us-ascii?Q?HJmoJK+qC9urJ/JZjjynBzY85OpM9H4I036gvptzkY5HACWCliKcqlA1Qish?=
 =?us-ascii?Q?rkeZRgtAwSc4ZLNB1m4EyHiSwdKvAxr2IbJX9jxy8iADQxoGiokWkNRDEDRW?=
 =?us-ascii?Q?GkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afed79fc-9b8c-4d72-de82-08d942b446a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:33:49.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6SNDvid2S18bCXlgziEsven5sglAm2sx8Pxk94Xt7fJSDp8NlszkT+cXKjgiSqb/+ddsXXOru41drQKB54wWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8616
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 9, 2021 3:25 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> mdf@kernel.org; trix@redhat.com; arnd@arndb.de; Rajan Vaja
> <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> Tejas Patel <tejasp@xlnx.xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Ravi Patel <RAVIPATE@xilinx.com>;
> iwamatsu@nigauri.org; Jiaying Liang <jliang@xilinx.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>;
> chinnikishore369@gmail.com
> Subject: Re: [RFC v2 0/4]Fpga: adds support to load the user-key encrypte=
d
> FPGA Image loading
>=20
> On Wed, Jun 09, 2021 at 11:22:28AM +0530, Nava kishore Manne wrote:
> > This patch series adds supports user-key encrypted FPGA Image loading
> > using FPGA Manager framework.
>=20
> Why is this series "RFC"?  Do you not think it is good enough to be merge=
d?
>=20

As it's a new feature to the fpga manager subsystem. So i have posted it as=
 RFC to get the inputs.

Regards,
Navakishore.

