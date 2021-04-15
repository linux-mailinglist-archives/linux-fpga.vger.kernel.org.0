Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF0F360213
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Apr 2021 07:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDOF6V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Apr 2021 01:58:21 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:1985
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229793AbhDOF6U (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Apr 2021 01:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkgZvg+GIQRjSCQ49ZtCGw2sTMYyUHV+sDtjw95wiM1l8ntOCTfFTAv0buk/RUtA2KVkHnqpLYrGOle1HOUoRPcZMd1riTtRbrFOz6ijXf6aVqNrVZvLsPkzzA6aRsuJZMJsTvd/6zW4DrTQxVcn8FN/Eqx5PoAO5reZXfB/YKUOBjzqAKokXf/cWIACOFNw6UXfHlNP25Zj8CUiKF1lakq2gIlMNe7oknXEcg7Xv+jGkFQWKJNNwGKcNV/nhMEEx40lzk9CWG4uOhNG4MlXge3dAg9JQkhjMBrahX/GmL4q0vvh9dB7CwFdr+//1zPqRjmKN3SxcjOwe5U1ZP1/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iteblqPP34YKv8hIf9zDqtgqowaphHmAITW9IAPBth4=;
 b=jP7nNytyMref6XBHjoKgiIdjKgEVJaeiNuOwcdLnTKvJtQMLu1MTUd7gNVaXU8W3mSndFTOZMoDklGrWATe+zuqLmBo8eZOpVynMbToXDLnjq1OQITHUqNNEWhN/GJ6Os7EhpQbca5qg1YyGt8b/9NMS8Qe60BRtOaGBp0OwYIafDcIydRi7zlCGP3qpND1kpsodveNI6YyNeddozJSpAbhhR3lshw7q4c8yzwQbpIa4CGVkT7eax3AcHY9cFN7gOvup5891COWpgMY8LIPDv4c36X7nYKVMWvjX11dRwbOQOaluj/TIlfKLqHJuoiedYEWf61KaRzntdK6JiubcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iteblqPP34YKv8hIf9zDqtgqowaphHmAITW9IAPBth4=;
 b=da4I5poqIy7s9YAlGoWjE8k+YYWtWSID61VD3ttCWy32Jtvu0IpI6RX/YkfnZNQF7KOo6PssBrMYciDVJ1ZppbZMNshiPn7z18EuWq6c0EJiQdIEch1cCmkofCFWh3OWQx7dH3NA/pKEdjapZ3o195Z6tALE8H/sl8101wMXaHM=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2207.namprd02.prod.outlook.com (2603:10b6:300:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 05:57:55 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 05:57:54 +0000
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
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgEAJlgCAQnFyEA==
Date:   Thu, 15 Apr 2021 05:57:54 +0000
Message-ID: <MWHPR02MB262373853A19250FDFB7CEE9C24D9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook> <YEAXxuU2J1yaAl3U@archbook>
In-Reply-To: <YEAXxuU2J1yaAl3U@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3cdbf23-783e-4396-912d-08d8ffd369a1
x-ms-traffictypediagnostic: MWHPR02MB2207:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2207C118F93F91F096660B44C24D9@MWHPR02MB2207.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3BXVH29dmnHqnUcztrVxg9tJbJNEnETn0lBKvYfcloCLzFerkl2FUfzIVFL5uCYV+OKMeZ1kfu5DNBRIf1lMUtiV/a95LfXBQUYyhzkiiYJRKYk/GP/I7dSyoEZ6zl7rOfewEOsX571Gi1lW4JTK5q2IdEU/Ps4aRgahZPUPU2dhHi3NcfHpWYBETHSRp5tZXnzVvUTmGB6CgLnP1mDmT3zB9nLIhRrm9z/Ua2oR3UAKQxTiVr1K0ArW6xidGNmAPX/ayAqx24qG5qq867oVKFuC9dwqxOjJpkvj4UoNXg/DUXsFbUqg6LEHhxKK4Wq/m+d/BBbOy17E1yHzxp9TzxG0MeP69GjMkpvaGsW59lf1KAREBC8nBdOGJk7uNixFhto8LqwTdlZM2PgXN4SWzrshn3maGpLx+O+OYbnFO2h6fAokHAi2qRKfm9KvpxsQbTFJpD5xCj062tXM1E3xomFIoc+hxlW1MwwkKCCJTaMl9MTah44tycRrC9ySWPmaHLhAWvJKCxj1GkHf3c8tQjPcK6in8dJ981dqqNTXdDisfGnbnN5GgtRpXetY/sZ7/TSNcJiA4dg0u3fWnE8wp+brG+4YLXsBvmMBQ30syM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(66946007)(54906003)(122000001)(76116006)(64756008)(38100700002)(6506007)(8936002)(5660300002)(66556008)(66476007)(52536014)(7696005)(8676002)(316002)(33656002)(6916009)(2906002)(26005)(86362001)(66446008)(71200400001)(9686003)(53546011)(55016002)(4326008)(186003)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kj3wk5AFPeZ/3gMRQJdrIhRDgDzEjdJDV/rBOhJjGRupAZjxFN5hGrsulQLp?=
 =?us-ascii?Q?w6V76+0Q5FMJkQcLC3yzh6YsaMkHRpl9fZpje3PbAGwIz57QwG0Ubc1RdKIo?=
 =?us-ascii?Q?iPSa1i64M3tSDgNymEIunJwUUTVrFO6SHee1pavrsrMIOEG3gWLjx6WBC9Wd?=
 =?us-ascii?Q?JcBLA03DJYW9pr1Vcn/NlIL6IBo/mYfaVSea/NO1sNXnI5l7qS4WU8i0EcBU?=
 =?us-ascii?Q?6lHQG2vIZ+Di3Ahba/9wUGQpKmjyvfa4GVM6S+fJ+g/ZUP6zHsYA/mMyUj0g?=
 =?us-ascii?Q?6awiT5CAyIhhpD/eIaith9s3gpzsMGphrTMlh3pghZDcu5CKhLL0Yp6cZczD?=
 =?us-ascii?Q?HDvIKmKgSiCQjxRDlfNYtp+CqbWuxf9JZUNbgra9qkz9jPqjvqYkjve1M+w0?=
 =?us-ascii?Q?WZ2B3bS1jVRlFFn5fFkjNtwMhyU797GWU+JAGS3W/yFN1PNhSjZja7hKLjwT?=
 =?us-ascii?Q?wz1fd1JV1szpeknCAuUC0s64WFFDMK9Rx+jZUYEBjb40YjSlBxgWqDiAiwVb?=
 =?us-ascii?Q?Sq03XHjs6AuFFo6X2losapIXalWlsw8dOo3NVaNWwG8niGkaL91ADB6QPzo6?=
 =?us-ascii?Q?i8slNvloFwZnSS4VfRhpqkXX0zMU3E++Rv9UYl3frTqcCy3CdLrd1rLvIEQn?=
 =?us-ascii?Q?6c3yYW2WDkOIjqKFpd3Ky7bwC5h7M58YIiuj/uO9PPIw/TrZuqdvErwgOKbH?=
 =?us-ascii?Q?kp+gVBS6HLL92stNZC1Lpef3IwTDn7E9rfpFP+0i845g1E9/3gp3paeoPPuw?=
 =?us-ascii?Q?DLXBX6FR/xoXn5sI4ocfDEcA6BmKhtGouYZKChv4hYbkFwd8Cxm84JdM7U+H?=
 =?us-ascii?Q?0fssDDRwOP3BU1JVmAr4tDjAcrunR3DuAUCTsSTLPhrARLqV9eYZ97lOwvaK?=
 =?us-ascii?Q?JlgOPL8qKAY/vGMADl7WzeU0MEOtEhUQw/ECGCfyb2zlmvn1mBFDAyHq1fMm?=
 =?us-ascii?Q?oNNfiFEVPVqRwSRF1xZ0hYVTFsDsuuA7Up2TFQTaS+Ro1Z5bf+p40FniRM68?=
 =?us-ascii?Q?aj/5PoqLGULH/kADc6h+4qx/rBjHd5B8FWmATTJBSjs2y41VpxnwKpk0wRho?=
 =?us-ascii?Q?vzlwYG7LHjapbApY3nzAzZnQt3PyNB+NoGPyYTEAxwOofgbxvwslzmoOqhxA?=
 =?us-ascii?Q?KzJUgQE1h+l7N6ZkwszYyFHU+jpVje/pxEmEfNEx9ZsObv9Kpz0YB0PnnnGe?=
 =?us-ascii?Q?u8LIhGgBQP+FjWY0KhB1aivAGBtGrQfR/fmeC8R2Rq2w0Z6xoZ2yIGhRq6lb?=
 =?us-ascii?Q?8gsJsPHC26cN3G1RYwE88kV8X4QG8ZCo8mM0t2yhQYsOhWfjNaSyORqSEC6F?=
 =?us-ascii?Q?kxKPuj+0Ziv2Q+sxP9YE+LuP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cdbf23-783e-4396-912d-08d8ffd369a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 05:57:54.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LojToThkOgFhfTNnh1PMbLptYLbPviwa3KHobZySLDX4XCn6BFYbm13/GwVhzoYQrPxXcDbKVYuFDEwVxl9U2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2207
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Thursday, March 4, 2021 4:42 AM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: Nava kishore Manne <navam@xilinx.com>; trix@redhat.com;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> Hi Nava,
>=20
> On Thu, Jan 21, 2021 at 09:17:10PM -0800, Moritz Fischer wrote:
> > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > > This commit adds secure flags to the framework to support secure
> > > BitStream Loading.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/fpga/of-fpga-region.c
> > > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > > 100644
> > > --- a/drivers/fpga/of-fpga-region.c
> > > +++ b/drivers/fpga/of-fpga-region.c
> > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> *of_fpga_region_parse_ov(
> > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > >
> > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> config"))
> > > +		info->flags |=3D
> FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> >
> > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > > +
> > > +	if (of_property_read_bool(overlay, "ddrmem-authenticated-fpga-
> config"))
> > > +		info->flags |=3D FPGA_MGR_DDR_MEM_AUTH_BITSTREAM;
> > > +
> > > +	if (of_property_read_bool(overlay,
> > > +				  "securemem-authenticated-fpga-config"))
> > > +		info->flags |=3D FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM;
> Shouldn't all these get binding docs? I remember Richard adding
> authentication support for an Intel platform, too and I'd like to avoid a=
dding
> random bindings per vendor.
>=20
> Would it be possible to have an 'authentication method / type' that is mo=
re
> extensible with different methods maybe?
>=20
Yes, I agree this flags should not be a vendor specific we should make it a=
s generic.
can we have flags something like below .
1) authenticated-fpga-config --> By default it uses kernel memory(DDR) to a=
uthenticate the image(FPGA_MGR_MEM_AUTH_BITSTREAM)
2) authenticated-onchip-fpga-config --> It uses the On chip memory to authe=
nticate the image ( FPGA_MGR_AUTH_ON_CHIP_BITSTREAM)

if you have any other thoughts let me know will try to adopt the same...


Regards,
Navakishore.
