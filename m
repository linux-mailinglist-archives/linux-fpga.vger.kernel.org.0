Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165DB2686EA
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgINIMT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgINIMB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 04:12:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E9C06174A;
        Mon, 14 Sep 2020 01:11:17 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r10so3819609oor.5;
        Mon, 14 Sep 2020 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiWoOjbocYfXto48nFLnUJJva/vgzYIMpRgWmcqUVDs=;
        b=Es9faI85dVSrPMxn0/fxuP7sdWsK/0diEepgIjPk/dolJsGVXyXaJcE84ZAqlfEbG8
         VOav5EgR/PrSf54d3FbyzU27k2pPhCCGyuRVq8aOq9ZlKv8VczCg7YIkSEpGCtBXZAxn
         wmvqi/bMDSg6n9YTstMaOB4kWx9bGuAUKl0mOuRS6msZz0vQ18NnAds3hsu4mFjq3lJD
         bcPZaUVgI3LqfDfOvKhV1V4jH2PvEqAyIodcnKcHZjWog7Dcd6Bb7iBhxVL/amy5OsgA
         lbdM8oMAVGm9FI37sD7pzz5DifOVGork/yNa+a9cd4WtCGnGth0hZ/oBiZ5ytRVsnhXE
         VSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiWoOjbocYfXto48nFLnUJJva/vgzYIMpRgWmcqUVDs=;
        b=bLZho3gkzks2LkRmg3fX3XAF7N2plp5MMoGt+nl/Bbc2Ktylkw6b/18aVeZ6RBqLZa
         qYWbg5jFdkWikzDvAuuEFak8piTpYOEC5L7ca6oWQEjjepcTpbQIPrDL7YwkaBc8g/3J
         a1BGHAnAwG3vamtWXMJTdxJsKdnv+mKmMWtsVS+zK4VMn8vcz6NZpJerxD1mMYQr6B8z
         qfxPIW50GZkLCktBCXMN+b4FAKUVWW4dEbaqbF5cP/mcpKki6goAvukkGhZ+xYXNCgMO
         61KiOBciRsINFlnmyZ7VAbY9WOoOrFIQE/KniPD05+olCr0lu/5IDidG3Qc+Bi5vf7HC
         uWsQ==
X-Gm-Message-State: AOAM530qP5SFD238HBGmsoXfopvSS7RTEVBBZNmz/eW3uvN/eiJ0v70/
        mAJkgGTiBbY6zLEAodRV1jHoVtTxL9uYpW+m0Mw=
X-Google-Smtp-Source: ABdhPJxZhyRmN42yl3RF+whdW88Pd2by4L0LHlHrWkTJzCU4W1n0q8o+I3PJmU1dSGpY31ECu/Dr7d9iqvYxm9/8VfM=
X-Received: by 2002:a4a:5403:: with SMTP id t3mr9632108ooa.11.1600071076339;
 Mon, 14 Sep 2020 01:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200810134252.68614-1-alexandru.ardelean@analog.com> <20200810134252.68614-8-alexandru.ardelean@analog.com>
In-Reply-To: <20200810134252.68614-8-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 14 Sep 2020 11:11:05 +0300
Message-ID: <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mturquette@baylibre.com,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> These patches synchronize the driver with the current state in the
> Analog Devices Linux tree:
>   https://github.com/analogdevicesinc/linux/
>
> They have been in the tree for about 2-3, so they did receive some
> testing.

Ping on this series.
Do I need to do a re-send?

>
> Highlights are:
> * Add support for fractional dividers (Lars-Peter Clausen)
> * Enable support for ZynqMP (UltraScale) (Dragos Bogdan)
> * Support frequency limits for ZynqMP (Mathias Tausen)
>   - And continued by Mircea Caprioru, to read them from the IP cores
>
> Changelog v1 -> v2:
> - in patch 'include: fpga: adi-axi-common.h: add definitions for supported FPGAs'
>   * converted enums to #define
>   * added Intel FPGA definitions
>   * added Device-Package definitions
>   * added INTEL / XILINX in the define names
>  definitions according to:
>  https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_intel_device_info_enc.tcl
>  https://github.com/analogdevicesinc/hdl/blob/4e438261aa319b1dda4c593c155218a93b1d869b/library/scripts/adi_xilinx_device_info_enc.tcl
>
> Dragos Bogdan (1):
>   clk: axi-clkgen: add support for ZynqMP (UltraScale)
>
> Lars-Peter Clausen (2):
>   clk: axi-clkgen: Add support for fractional dividers
>   clk: axi-clkgen: Set power bits for fractional mode
>
> Mathias Tausen (1):
>   clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
>
> Mircea Caprioru (2):
>   include: fpga: adi-axi-common.h: add definitions for supported FPGAs
>   clk: axi-clkgen: Add support for FPGA info
>
>  drivers/clk/Kconfig                 |   2 +-
>  drivers/clk/clk-axi-clkgen.c        | 253 ++++++++++++++++++++++------
>  include/linux/fpga/adi-axi-common.h | 103 +++++++++++
>  3 files changed, 302 insertions(+), 56 deletions(-)
>
> --
> 2.17.1
>
