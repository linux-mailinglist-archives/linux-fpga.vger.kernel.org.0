Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3D269BFF
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 04:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgIOCll (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 22:41:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42866 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgIOCll (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 22:41:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so561939plt.9;
        Mon, 14 Sep 2020 19:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHjOcLugsS1SRAv7GbtgkiQstwhlZjOU+yVJ6z7LPrk=;
        b=cNbyrhSF/E05VKNcdW+jWgS5VM/W4boIHGa6Inp33POOhAgcas4IdMVqwYxZPG2zU4
         Ecz0qIhgX+DUHesZ2oQGpOCyE2rmbc3tmo5qCvkOxKfSPEKvUHGNyWqAoaP5k+oqEODf
         bZhbUjiGxjtftY5wjC23fV++CCt7cg+bBEP3vaoqvYhdwBJDXn9pcKFPGfmRascjdcxh
         KeqXH/i7n4PzEuDsiAvxxisKxZJOGeim6TpXzx9pSXH/urze7tavMfCGm8PrTeKBQhsT
         arnglWghEUST0PAlKJSpmm7M+p7AhWMR3Z7GgL3C4YbUfNRHgv5gZqbCDrvBSxOgvoms
         BGyQ==
X-Gm-Message-State: AOAM532tBSyRhIF5z9k59tsvbT2uaaoN2SQMoEL68WaL8pXfCUzLBnMQ
        Qf7kBMJtTOBDq8pGffKUJc0=
X-Google-Smtp-Source: ABdhPJwdgoc08BybLtLJFzoD06lY58Wrp6GZp929awbXLqXQozQi4x60y4DETIU7MAnPPU/gucFUSQ==
X-Received: by 2002:a17:90a:bf8c:: with SMTP id d12mr2174814pjs.157.1600137699394;
        Mon, 14 Sep 2020 19:41:39 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d8sm9411332pgt.19.2020.09.14.19.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 19:41:38 -0700 (PDT)
Date:   Mon, 14 Sep 2020 19:41:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mturquette@baylibre.com,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
Message-ID: <20200915024138.GA1827@epycbox.lan>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
 <20200810134252.68614-8-alexandru.ardelean@analog.com>
 <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > These patches synchronize the driver with the current state in the
> > Analog Devices Linux tree:
> >   https://github.com/analogdevicesinc/linux/
> >
> > They have been in the tree for about 2-3, so they did receive some
> > testing.
> 
> Ping on this series.
> Do I need to do a re-send?

I've applied the FPGA one, the other ones should go through the clock
tree I think?

> 
> >
> > Highlights are:
> > * Add support for fractional dividers (Lars-Peter Clausen)
> > * Enable support for ZynqMP (UltraScale) (Dragos Bogdan)
> > * Support frequency limits for ZynqMP (Mathias Tausen)
> >   - And continued by Mircea Caprioru, to read them from the IP cores
> >
> > Changelog v1 -> v2:
> > - in patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
> >   * converted enums to #define
> >   * added Intel FPGA definitions
> >   * added Device-Package definitions
> >   * added INTEL / XILINX in the define names
> >  definitions according to:
> >  https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_intel_device_info_enc.tcl
> >  https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_xilinx_device_info_enc.tcl
> >
> > Dragos Bogdan (1):
> >   clk: axi-clkgen: add support for ZynqMP (UltraScale)
> >
> > Lars-Peter Clausen (2):
> >   clk: axi-clkgen: Add support for fractional dividers
> >   clk: axi-clkgen: Set power bits for fractional mode
> >
> > Mathias Tausen (1):
> >   clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
> >
> > Mircea Caprioru (2):
> >   include: fpga: adi-axi-common.h: add definitions for supported FPGAs
> >   clk: axi-clkgen: Add support for FPGA info
> >
> >  drivers/clk/Kconfig                 |   2 +-
> >  drivers/clk/clk-axi-clkgen.c        | 253 ++++++++++++++++++++++------
> >  include/linux/fpga/adi-axi-common.h | 103 +++++++++++
> >  3 files changed, 302 insertions(+), 56 deletions(-)
> >
> > --
> > 2.17.1
> >

Thanks,
Moritz
