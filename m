Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1434370F9
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Oct 2021 06:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhJVEi5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Oct 2021 00:38:57 -0400
Received: from mail-dm3nam07on2062.outbound.protection.outlook.com ([40.107.95.62]:46561
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231134AbhJVEi4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Oct 2021 00:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmNU+lQRLYfOsBr6QbNe+p3rrohBG5XraA/jfGfP6ruvBPU6Ps4HvqyVG0Ki0bdHxbvQSUBq8uuQc1XBYkjYRYpDGEaRtMs1ik44z7W57pujAaymTeuBSHrHtteNBZxbW/egCfNRRyy+x7DiW1y6movAoat/DH3Scf0OVsB6XK4A5fL8dHSTUVsTrj5rNpZ7fiJgsl+Q44T33Xkg1keiELF8X/VHsgOTbY/XzFBRv8sf785QsTOGMkOXTlzNGIRDhKovIhDlKGQUVkBrlI3YT7C46Ss45F7jg9T73FWffIINLt3KVcJbw+9odbgqc7znEL13V0MsmrJ8f8eC0Mp7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf89Opv15b48xIbzKjFqpSbC55tWqF9eZgwXLoBl+k0=;
 b=ACYKHn28CDAQ5dL+P381xH62dGQOwUsEW4JRyQO8g9DVved4ygIhJXhmkEl4Wzg+Izbs2ev/Nrpd2svAL6RGyDWV+SstlR6Sw5ATdvJWZZx14qU7AHOVV+grd2JJPGUtW3TGglWWvmF+IqKougtfTN1THTmhzDg074jahTq+F+RSpgP9p91RsjpIySbXY2JYDySDgLW0TbXNsJkqcVM7xl2rJu3A6FiQ/cVrx7GwbNfmQRHTRTTdX0kPrjD8RJ81+OhCaFLwA/3+tsi/iClkFHzERqonzcv8LI7B4bYsVX3BjKy8G4bENcuhqzmA/KBDkDa+TI7UDByQKBzt5EpAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf89Opv15b48xIbzKjFqpSbC55tWqF9eZgwXLoBl+k0=;
 b=iBoC/oN8NxCgvZmKmUTPOZwawhVyZh58VLh0jET7wE4yZGfA7jlG4Z2qWY4t1H7z44fJJPxfL2X2i6IspFptW6Y/2+r61d3FEfC0jO3S65MpbYB8pg+mAWL6ga2+toF/abinSOejamq1Zg1Nd4scinrgjjml9GFp0bBbhOxE63A=
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com (2603:10b6:a03:3d9::15)
 by BYAPR02MB5414.namprd02.prod.outlook.com (2603:10b6:a03:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 04:36:36 +0000
Received: from SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::99df:f9a6:46b7:8eee]) by SJ0PR02MB8845.namprd02.prod.outlook.com
 ([fe80::99df:f9a6:46b7:8eee%8]) with mapi id 15.20.4628.016; Fri, 22 Oct 2021
 04:36:36 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Yu Liu <yliu@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
 describing XRT Alveo drivers
Thread-Topic: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
 describing XRT Alveo drivers
Thread-Index: AQHXwRZT42sxzSlZ7UucM2Fcbi/fLKvaURMAgAEDFqCAAm6jgIAAtL9b
Date:   Fri, 22 Oct 2021 04:36:36 +0000
Message-ID: <SJ0PR02MB8845B91BA06D0444D9466B4FBB809@SJ0PR02MB8845.namprd02.prod.outlook.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
 <20210802160521.331031-2-lizhi.hou@xilinx.com>
 <20211012050931.GA95330@yilunxu-OptiPlex-7050>
 <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
 <20211014022122.GG95330@yilunxu-OptiPlex-7050>
 <cc261622-5104-39ae-7221-b33dd70303e5@xilinx.com>
 <CAL_JsqKoHomBBzggK0RzoWxPjnvZijS5v6NympozLz62P-NOvA@mail.gmail.com>
 <SJ0PR02MB8845BABAB67F3A9F98285A74BBBF9@SJ0PR02MB8845.namprd02.prod.outlook.com>
 <CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 17ccef69-ac58-13a3-0d2d-6c60df208cbb
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 972ae44c-7c58-4af1-9f85-08d99515886f
x-ms-traffictypediagnostic: BYAPR02MB5414:
x-microsoft-antispam-prvs: <BYAPR02MB5414A83A528CA40935021825BB809@BYAPR02MB5414.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYcphbCLtkdSSb3b+9JS+ZRsELt1bsNYoNwzxbCrI01ftCuee6QWSNwNr3LlqSHNlyfRz8Qn0g1TVDmcJ/ShQ+FOQvgkSIPbIlNvrIJDZknIaqcz5/BZ/ZkGJ7zu0VBrtZBkUOnr89GciP490D5v7pKdFzfD27wCkGPK8w/WOOhMSnus6JrZ5qxsJ5jjXXSmCBh/7m/KXP0q/0RCngQ0ikT50N70/Gghm96TlwkIbHGHV46EvGC5kbRjkuthKzrEQmuLr/2wYyg7SU3Js4aPkgKkv/TcNyhPf71Pwh7B3LB9K+XeCNu/XJ/PIUeRrLEhr1JGCPxYAyLda7+vuD5Zw7rJxX53itBZeOMscB7Hmjiuo6HQA9JfdBj/9rUXiktbLED9n+LaImo5HZFV1LqwSRyUlIrR7RmXBcEmrE0ADw9Asr6xekEYv12wW7fp66mGSXmizIlEbV7xY7u+KLpzsDI6RqesY9VXLLpWQIEoSosk26NFaBogXH6RymFZjZmYaHL4JN5XkiJWkWorJkE6hItBI/IPgoA7s1R87WK1q3A0LZXcvWuUJ3NfbyIpXXlYykNCEPVl/LyCHuFMPFcJL8v26jSnNgBGDdyd/4HOsxlj0Q5nXUfpq/Cl8ug5eMBajfyLZKHttjR2qbvVC7t971+hXy4d39PrO1YdE4esKB7sU2tRcfzFoosLc4KKEoYqgpVtdGSrA1IvTyFf6KKgqsVbfz/LJ59hlhR4BXvBt2bst3qRBDk2QWoSxMXl8UN2kAOwckZoWUoVhoRA/uZzWPT5KUHNmkHqfY0sXyy+aN4DAXUJ5/Nd1/HOPZhkTQFs1l34RInzIHQVWUnV0W4kqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8845.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(7696005)(53546011)(71200400001)(52536014)(8936002)(38070700005)(508600001)(83380400001)(45080400002)(2906002)(26005)(54906003)(66446008)(5660300002)(122000001)(9686003)(316002)(76116006)(6916009)(8676002)(966005)(38100700002)(33656002)(186003)(66556008)(86362001)(64756008)(66946007)(66476007)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?img0vrwlarSCH/t/dU8JgITIH8EsFVpzjlExtXeqGuAZwOalYDele9TnrKpQ?=
 =?us-ascii?Q?Zbd0mUApxVqEjudTNkY30klJdnAllrQhfYIkqm1QVrKGxZYQ612IIxq6xYQ5?=
 =?us-ascii?Q?X/+UdkJOx4M4usDdr76vSYXRO3rxQ+qYICHyvOPZGwl5YqaK/rt2jFAAV66A?=
 =?us-ascii?Q?RMnQSdhUW+BUoMsrdVCbz0vkNyzzyfSBV8eTooVpdznRAAcYV6T47XArTxRl?=
 =?us-ascii?Q?JN02BDwWlNbjMejyy2i4M+po8nH3UJdMSP3CK8NHhI50vJBgp310EF7qvYpb?=
 =?us-ascii?Q?bTx7uMeywCC5/tTshTiQMl3JEj/iKn2mPuIvPGTmIgcW/Ar5wME7cYNUsS48?=
 =?us-ascii?Q?k35r4UtFdwY/P0alrxqPkG9W9mna5gFvQ9wZAvE0JUYsX3QExEWqPNSy7qk9?=
 =?us-ascii?Q?OvrnchfOUzxU0W0N1jKG4qHQCpVl9zvzBX1nLGlrbz50tCKNlTVmIaoqBhoE?=
 =?us-ascii?Q?9gk8Pk22zMh8yasCzlxZn37IMlP1riFgnld0JjJU7bCUwGBDBjlh0X5tMRjW?=
 =?us-ascii?Q?1tn+3ngEunhuRqUBFv5uMbz9269GwAZR79DwwC+YKkqOHGOca2KDY3TB4+dc?=
 =?us-ascii?Q?cVD+k8Pl1FTfaK4mlRfQ+fKazLU5ce0/71d74avFnN2o2gHD8eWOcQGVGJjW?=
 =?us-ascii?Q?5QJgp/lfICzgf+wn08tW3PEDSmdASd577q4h8ySp6jzPdAPBLSfQ0EFaPyFu?=
 =?us-ascii?Q?S7NUDwrlROw8NDgbQI8W78LuISctyNtKLLge/yRQ1wkiI4OWfBGxhsvOdcLH?=
 =?us-ascii?Q?ApGyXQfcgD2+r+VdpmD0FN9UCsE7JVseoo3evDMho7FBxsTb6e/XovYqLTsg?=
 =?us-ascii?Q?bitJIbtD1bq9QdczvtO+uIu/41NxfV2UizoWVE7Dy63CO0bnxnb3PF26Uvb8?=
 =?us-ascii?Q?ooMwSjAHo0L11z0xd9/yXPUiFvqH84xCPz9C/mOfixGXAuSGR01PzlVAcWiK?=
 =?us-ascii?Q?2R0zV2Yb/QvZk+f+chEYQiFz5eY38B6oaNt10EPxh85Wim6DpvFztHSNpSKU?=
 =?us-ascii?Q?76DZtjHQdRDGqUk3s0Q+ILkf/FXH2SRLhhyIQFmHUmrtvRD1blTIdvv9pO3H?=
 =?us-ascii?Q?6Ds5pBmQlay7vCsB4r6zX6JEeBlO0252JtCDAOCrcy7xZ0TYYFJAFaWOfdRy?=
 =?us-ascii?Q?ExDJgePavUToFvo9d44olqXvxOI2KkBe9gPI+oJUqMh7FoGP8XAai3HQOZxi?=
 =?us-ascii?Q?qu0I2FrSsFZUfgojURI0Oe6bQqZXqeCI3XeaVEMDkHbAkeznGBfxk3SYuHRr?=
 =?us-ascii?Q?Io2fGzgn0UN2gwLpE79TG5mycHOsoMG8WlnT82nuOKA+yR6/jZHakX+2YCVd?=
 =?us-ascii?Q?UEX75PXp/AJnCx14MRjqJsYwb/TFxzK+Olfu+nvu+q8AHjnRSVd77KaXN/91?=
 =?us-ascii?Q?7AIqa99opmLEqTQEJYSWi4lHSNvHaeSXkqcO4JdClQEGqu4nFDVQoNvFzdYO?=
 =?us-ascii?Q?4DiB3CXZP6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8845.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972ae44c-7c58-4af1-9f85-08d99515886f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 04:36:36.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sonals@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5414
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for your suggestions and pointers.=20

We will look into creating a generic patchset for attaching a device tree f=
or PCIe use case. Will then refactor the XRT Alveo driver to use this new i=
nfrastructure.

-Sonal

________________________________________
From: Rob Herring <robh@kernel.org>
Sent: Thursday, October 21, 2021 10:38 AM
To: Sonal Santan
Cc: Lizhi Hou; linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Ma=
x Zhen; Yu Liu; Michal Simek; Stefano Stabellini; devicetree@vger.kernel.or=
g; trix@redhat.com; Moritz Fischer; Xu Yilun; David Woodhouse
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document=
 describing XRT Alveo drivers

On Thu, Oct 21, 2021 at 12:36 AM Sonal Santan <sonals@xilinx.com> wrote:
>
> Hello Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, October 19, 2021 6:03 AM
> > To: Lizhi Hou <lizhih@xilinx.com>
> > Cc: linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Max Zhen
> > <maxz@xilinx.com>; Sonal Santan <sonals@xilinx.com>; Yu Liu
> > <yliu@xilinx.com>; Michal Simek <michals@xilinx.com>; Stefano Stabellin=
i
> > <stefanos@xilinx.com>; devicetree@vger.kernel.org; trix@redhat.com; Mor=
itz
> > Fischer <mdf@kernel.org>; Max Zhen <maxz@xilinx.com>; Xu Yilun
> > <yilun.xu@intel.com>
> > Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a
> > document describing XRT Alveo drivers
> >
> > On Thu, Oct 14, 2021 at 11:12 AM Lizhi Hou <lizhi.hou@xilinx.com> wrote=
:
> > >
> > > Hello Rob,
> > >
> > > Please help with the review of the proposed FDT usage by Alveo/XRT dr=
ivers.
> > >
> > > Thanks,
> > > Lizhi
> > >
> > > On 10/13/21 7:21 PM, Xu Yilun wrote:
> > > > CAUTION: This message has originated from an External Source. Pleas=
e use
> > proper judgment and caution when opening attachments, clicking links, o=
r
> > responding to this email.
> > > >
> > > >
> > > >>>> +.. _device_tree_usage:
> > > >>>> +
> > > >>>> +Device Tree Usage
> > > >>>> +-----------------
> > > >>>> +
> > > >>>> +The xsabin file stores metadata which advertise HW subsystems
> > > >>>> +present in a partition. The metadata is stored in device tree
> > > >>>> +format with a well defined schema. XRT management driver uses
> > > >>>> +this information to bind *xrt_drivers* to the subsystem
> > > >>>> +instantiations. The xrt_drivers are found in **xrt-lib.ko** ker=
nel
> > module.
> > > >>> I'm still catching up the patchset from the very beginning, and
> > > >>> just finished the Documentation part. So far, I see the DT usage
> > > >>> concern which may impact the architecure a lot, so I should raise=
 it ASAP.
> > > >>>
> > > >>> The concern raised by the DT maintainer:
> > > >>> https://lore.kernel.org/linux-fpga/CAL_JsqLod6FBGFhu7WXtMrB_z7wj8=
-
> > > >>> up0EetM1QS9M3gjm8d7Q@mail.gmail.com/
> > > >>>
> > > >>> First of all, directly parsing FDT in device drivers is not a
> > > >>> normal usage of DT in linux. It is out of the current DT usage
> > > >>> model. So it should be agreed by DT maintainers.
> > > >> Thanks for reviewing XRT document and providing feedback.
> > > >> Here is the reply from Sonal for Rob's question:
> > > >> https://lore.kernel.org/linux-
> > fpga/BY5PR02MB62604B87C66A1AD139A6F15
> > > >> 3BBF40@BY5PR02MB6260.namprd02.prod.outlook.com/
> > > >> Overall, libfdt is used by XRT driver to parse the metadata which
> > > >> comes with an Alveo board.
> > > >> When XRT driver discovers an Alveo board, it will read a fdt blob
> > > >> from board firmware file resident on the host.
> > > >> By parsing the fdt blob, XRT driver gets information about this
> > > >> Alveo board, such as version, uuid, IPs exposed to PCI BAR, interr=
upt
> > binding etc.
> > > >> So libfdt is used simply as Alveo metadata parser here. XRT driver=
s
> > > >> do not interact with system wide DT or present the Alveo device
> > > >> tree to host. For many systems like x86_64, system wide DT is not
> > > >> present but libfdt parsing services will still be needed.
> > > > Yes, I understand the use case.
> > > >
> > > > My concern is, directly parsing an isolated FDT in device driver an=
d
> > > > populate sub devices, skipping the unflattening, this is a new
> > > > working model of device tree usage, but for the same purpose as the
> > > > existing one.
> > > >
> > > > So I really need the confirmation of DT maintainers.
> >
> > Perhaps you could explain why you think you need to use FDT instead of
> > unflattening. Without that, the answer is don't use FDT.
> >
> Xilinx Alveo PCIe cards are predominantly used in x86_64 systems which do=
 not have device tree support compiled into the kernel. XRT driver uses a m=
atching FDT to discover IP subsystems sitting behind the PCIe BARs exposed =
by an Alveo PCIe card. The FDT blob (as part of an Alveo PCIe card firmware=
) can be freely downloaded from xilinx.com.

If the kernel is going to consume that FDT blob, then it needs to
follow upstream practices which primarily means all the device
bindings must be documented with schema and reviewed.


> If using an unflattened tree (instead of FDT) is the right solution then =
we would certainly look into it. Should the PCIe driver then call something=
 like of_fdt_unflatten_tree() with a FDT blob and the kernel would then bui=
ld an unflattened tree and hang it off the PCIe device node? The FDT blob f=
or a PCIe device is only known to the driver since different PCIe platforms=
 may store it differently: a known location in the PCIe BAR, the flash on t=
he PCIe board or a file on the filesystem. If the kernel can provide a gene=
ral on demand unflattening service similar to DTO use model, we will have a=
 more scalable solution to describe IP subsystems exposed by a PCIe device =
and make their discovery data driven. Can this feature also work on x86_64 =
systems which does not use OF?

There's other similar usecases like this. For example, an FTDI or
similar USB to serial chip that has GPIO, I2C, etc. and could have
downstream devices hanging off of those interfaces. And then you could
plug-in multiple of those devices to the host system. For this to
work, we'd need to create a base tree (if there isn't one) with nodes
for the USB or PCI device(s) and then an overlay for the device can be
applied to those nodes. This is also partially an issue on DT based
systems as the DT node may not exist given these are 'discoverable'
buses. It's a bit easier to solve given the PCI host bridge or USB
controller exists in the DT already.

There's really 2 separate parts here. There's how to attach a DT to a
device on a non-DT system (or DT system with a device not described in
the base DT). The second part is how to describe the PCI device and
downstream devices. This part is no different than any other device.


> > > >>> Current FPGA framework modifies kernel's live tree by DT overlay,
> > > >>> when FPGA is dynamically reprogrammed and new HW devices appear.
> > > >>> See Documentation/devicetree/bindings/fpga/fpga-region.txt.
> > > >>>
> > > >>> Then something less important:
> > > >>>
> > > >>>     1. The bindings should be documented in
> > Documentation/devicetree/bindings/.
> >
> > Yes.
> >
> > > >>>     2. Are all the example DT usage conform to the exsiting bindi=
ngs? I
> > > >>>        didn't go through all device classes, but remember like th=
e
> > > >>>        interrupt-controller should have a "interrupt-controller" =
property,
> > and
> > > >>>        the PCI properties are also different from PCI bindings.
> >
> > They don't, but should. I can't tell what you are trying to do here, bu=
t it looks
> > like a mess.
> >
> Will appreciate any pointers on existing PCIe use case for the device tre=
e.

Documentation/devicetree/bindings/pci/ and there's the PCI bus schema
here[1]. There's also the OpenFirmware PCI spec[2].

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/main/schemas/pci/pci-b=
us.yaml
[2] https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
