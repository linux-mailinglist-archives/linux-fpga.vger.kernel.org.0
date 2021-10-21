Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA543692A
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Oct 2021 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhJURlQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Oct 2021 13:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJURlP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Oct 2021 13:41:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F112611F2;
        Thu, 21 Oct 2021 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634837939;
        bh=LpNb5Ofiwydmq40FQU8duMylt8pFFZmKuTDr2i1rZIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKUD38yu6OZtErjhk2Qs5xIkQkkCFgxI2gcsBS9eGEs1l2jYMzjeg859x1/X64QWV
         vkcv0jFID8Xd6qSxzsexrZvBo1jlvaOcShqL+4jAlIB3xHu3qJGBEqSRyTpDSGJDIS
         F4WK8BHBkRJ1CCPcVX9FO3JQTcTf2srRcJ0ubDWiX2KyRCyqVRXMTXgw9Rs8Z4TFCe
         QKSGQ3nBnsER2zLtyJG6irupxiXLHm7EGZprrb2RMMO2wIgtRtig7NIJ8JbvXO8i/s
         NP0h4p7p+Oe0leUnfZ/A2ekch/e7q3DXZ6lkIopYID/jpHe+h8gnIA/xXfH/4yTX0d
         spTMj66k5Ulrw==
Received: by mail-ed1-f48.google.com with SMTP id g10so3907198edj.1;
        Thu, 21 Oct 2021 10:38:59 -0700 (PDT)
X-Gm-Message-State: AOAM530q+b2Mv4yp24ITvE1n1hz0v9aWtCDg8P5SAj8LpwPHqy639xKL
        IySMVhzldgKl8sln5JQNq66n3KROSL6RANI/LQ==
X-Google-Smtp-Source: ABdhPJz/vbdq3qrIZ6VKZxs1qt95sB5jOe4PZ1t0hVBlVmqM5S9SyIXFm9L+aZKMoHABRpPUFg0+0rgoH+mqfa+mN5E=
X-Received: by 2002:a17:906:c350:: with SMTP id ci16mr8528906ejb.466.1634837933642;
 Thu, 21 Oct 2021 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210802160521.331031-1-lizhi.hou@xilinx.com> <20210802160521.331031-2-lizhi.hou@xilinx.com>
 <20211012050931.GA95330@yilunxu-OptiPlex-7050> <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
 <20211014022122.GG95330@yilunxu-OptiPlex-7050> <cc261622-5104-39ae-7221-b33dd70303e5@xilinx.com>
 <CAL_JsqKoHomBBzggK0RzoWxPjnvZijS5v6NympozLz62P-NOvA@mail.gmail.com> <SJ0PR02MB8845BABAB67F3A9F98285A74BBBF9@SJ0PR02MB8845.namprd02.prod.outlook.com>
In-Reply-To: <SJ0PR02MB8845BABAB67F3A9F98285A74BBBF9@SJ0PR02MB8845.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Oct 2021 12:38:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com>
Message-ID: <CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com>
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
 describing XRT Alveo drivers
To:     Sonal Santan <sonals@xilinx.com>
Cc:     Lizhi Hou <lizhih@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Yu Liu <yliu@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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
> > > >> Here is the reply from Sonal for Rob=E2=80=99s question:
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
