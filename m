Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F186177BD4
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Mar 2020 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgCCQZI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Tue, 3 Mar 2020 11:25:08 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgCCQZI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Mar 2020 11:25:08 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MN4qp-1iqo7g0idZ-00J1ho; Tue, 03 Mar 2020 17:25:05 +0100
Received: by mail-qv1-f54.google.com with SMTP id ea1so1927384qvb.7;
        Tue, 03 Mar 2020 08:25:04 -0800 (PST)
X-Gm-Message-State: ANhLgQ3KuPU8Er9uvB3wub4lkd8IWr7BjSqxr1+d/gGQ02vgU6cVpSlu
        WGPCJ7NYP1gBOFXGXwDNrv85F7ioYYo4xENf/7M=
X-Google-Smtp-Source: ADFU+vthSje+AVJvGg4Efjcw6MeRkM8IwE0D1YApiIxSNHgFg5iRxgjF2TFIOLQBm42Ch8/7AvxSa+snlv4AuynI9xQ=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr4354485qvu.211.1583252703942;
 Tue, 03 Mar 2020 08:25:03 -0800 (PST)
MIME-Version: 1.0
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com> <20200303154522.GA24568@yilunxu-OptiPlex-7050>
In-Reply-To: <20200303154522.GA24568@yilunxu-OptiPlex-7050>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Mar 2020 17:24:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
Message-ID: <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
Subject: Re: LPC Bus Driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     John Garry <john.garry@huawei.com>, luis.f.tanica@seagate.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, gregkh <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:WzF0cxHYEmzuWbB33qG/Gx/UdGE3V9K7mi7lyjyTXYE2JKvrx1+
 fFPIE1+cREp+p/U3kbDBhsMkiOThw03LRUkSFB8COvQYjC4IDu9GfSPhkvbihqHeomM3DST
 FQRv+YkfzAtqZ8S+klj1AK2yfILGRanDT0vMvoe7abYqg+NcPxEtnGudQFxKHp2+adxGhyO
 hAKXBJOo+kGQZX49CbEvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrC/Zx7KTV4=:+EWYh408B4h3ELkAShbWlz
 u4Ph+wKl02ZiSFlkSLWVYz+nbMpsUDDY6IQMApW3kitdMcgZKOcY3Rc/f8iBuv5W1UW0ldukj
 NtnQRGfM6zl44InT0zbOnXxYYcT649gWHp1B1HdpJbPQsEDBRvb661Mt6ZvRaT+NXrynfCFiq
 srIpZRuzQFyJzAJ27vO+HLFWJRn6ARnQjiR6hpwRsHs/exCLj1cMzXSyEK9L11syYASjaQ5Dr
 G0B2As++8M4jonHFp0FpGI+ndPV3sS0PajE95s87nQrsu9s6lRgg9uukRg9dCXdhvP+4QUOtt
 x/OwzXuBQzSwi2De4tpIjJhlXBDUXsJGT0QN9mMFdosqM4sIxoD9hRXSMOXVZShbeKHNlE1Ji
 E8NIAII8n/BxWzfBvJ5hdPCRcgLM/zkYAWkZNO3k/QNVBCL6osFZoVf1gicC8Xkquca0w2ra3
 P80Vt3+grgY73i1wtsfV7AJsQQd6BheVQHckz8lihfSSrwe9fqgY1jsDFPUjFd+jJ/sHhU2CC
 NQt4Ext0nv4Dlf/sILLL3rjxS3UFF7ytwthfsz9lYGOi7dTbLlTe9GZan7Uk6ncEehKpKHcDW
 uo0L74F0Jg31vDy1lO9a1JdCIklA6O/nFGbc5eWjbWn3N41I6fSHHkbaeO3Nt3qmkGTWoCb7D
 8+SS24AqClxD7Sw1svZpy93855x8XHt8Hio9PYP3/E0QH/DR1k/VD/9DZ2tSxrRFhi8chO4eV
 x1kpBnbxDE/1iX5o7GdwLKmpClBvGH2VYgHmEtSEJrED0m8qgAsy5X89cpOmMgUUc8/7aLkhE
 yY7AWEStdxQfm/LUOhKJ9x7LEKKGAJrQ3a5g0fUOdElXQuOCS8=
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 3, 2020 at 4:47 PM Xu Yilun <yilun.xu@intel.com> wrote:
> On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:
> > + add fpga list and Greg+Arnd for misc drivers
> > >We have this board with our own SoC, which is connected to an external CPLD (FPGA) via LPC (low pin count) bus.
> > >I've been doing some research to see what the best way of designing the drivers for it would be, and came across the Hisilicon LPC driver stuff (which I believe you're the maintainer for).
> > >
> > >Just a little background. Let's say our host (ARM) has a custom LPC controller. The LPC controller let's us perform reads/writes of CPLD registers via LPC bus. This CPLD is the only slave device attached to that bus and we only use it for reading/writing certain
> > >  registers (e.g., we use it to access some system information and for resetting the ARM during reboot).
> > >
> > >I was looking at the regmap framework and that seemed a good way to go.
> >
> > I thought that regmap only allows mapping in MMIO regions for multiplexing
> > access from multiple drivers or accessing registers outside the device HW
> > registers, but you seem to need to manually generate the LPC bus accesses to
> > access registers on the slave device.
>
> I'm not familar with LPC controller, but seems it could not perform
> read/write by one memory access or io access instruction
>
> I didn't find an existing bus_type for LPC bus, so I think regmap is a
> good way. When you have implemented the regmap for LPC bus, you need to
> access the CPLD registers by regmap_read/write, and just pass CPLD local
> register addr as parameter.

LPC uses the same software abstraction as the old ISA bus, providing
port (inb/outb) and mmio (readl/writel) style register access as well as
interrupts and a crude form of DMA access.

Whether regmap or something else works depends on which of these
communication options the CPLD uses.

> > If this FPGA is the only device which will ever be on this LPC bus, then
> > could you encode the LPC accesses directly in the FPGA driver?

I think this is the most important question. If the same SoC is used
in systems that connect something else on the same LPC bus, then
making it look like a normal ISA/LPC bus to Linux is probably best,
but if the CPLD and SoC are only ever used in this one combination,
there is nothing wrong with pretending that the LPC MMIO interface
on this chip part of the driver for the CPLD.

> > As another alternative, it might be worth considering writing an I2C
> > controller driver for your LPC host, i.e. model as an I2C bus, and have an
> > I2C client driver for the LPC slave (FPGA). I think that there are examples
> > of this in the kernel.
>
> How the host cpu is connected to LPC host?
> Why an I2C controller driver for LPC host? The LPC bus is compatible to i2c bus?

i2c is a simple bus that allows multiple devices to share a bus
and perform read/write operations on numbered registers. If the device
attached to the LPC bus fits into that, it might be even easier than
regmap.

       Arnd
