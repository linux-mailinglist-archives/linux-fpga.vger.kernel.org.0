Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70919274955
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Sep 2020 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIVTm0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Sep 2020 15:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIVTm0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Sep 2020 15:42:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE27221E8;
        Tue, 22 Sep 2020 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803746;
        bh=GFRBsj9K7jrHHePKuRmNnXLW6wr/JMGePhL8WYlgtko=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=13Orbs9cEwMpmMPmQXfUFPwwxuZciWYS8B1xzgTL97uRAuTRIa4OCQpC5MkH13NeD
         AKvgSg1Wun1Yd4wiHYxwQoIdS3AqO/Kkkd4V/MZXcx8pmpzvMHCl97fJSbFUkpBPFM
         +BxxBnAhuF69FPOxS2jUbxvrPX50u+Vzfoq4ycR8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200915024138.GA1827@epycbox.lan>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com> <20200810134252.68614-8-alexandru.ardelean@analog.com> <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com> <20200915024138.GA1827@epycbox.lan>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mturquette@baylibre.com,
        Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Moritz Fischer <mdf@kernel.org>
Date:   Tue, 22 Sep 2020 12:42:24 -0700
Message-ID: <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Moritz Fischer (2020-09-14 19:41:38)
> On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> > On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:
> > >
> > > These patches synchronize the driver with the current state in the
> > > Analog Devices Linux tree:
> > >   https://github.com/analogdevicesinc/linux/
> > >
> > > They have been in the tree for about 2-3, so they did receive some
> > > testing.
> >=20
> > Ping on this series.
> > Do I need to do a re-send?

I got this patch series twice. Not sure why.

>=20
> I've applied the FPGA one, the other ones should go through the clock
> tree I think?

Doesn't patch 6 rely on the FPGA patch? How can that driver build
without the header file?
