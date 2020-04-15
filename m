Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9E1AACF5
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410202AbgDOQGG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410200AbgDOQGE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 12:06:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2135C061A0C
        for <linux-fpga@vger.kernel.org>; Wed, 15 Apr 2020 09:06:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so4235020ljk.12
        for <linux-fpga@vger.kernel.org>; Wed, 15 Apr 2020 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXZyYCnse984T67Wd+QuaLUXZO8UfXRWQ0/2FMXWznM=;
        b=RVOmYGY7BJC+/GSsy5z37p49F4jKDa2o5MEE51D1YV+u23/FgFsOMWO4MoHgmZ3JKD
         wqdMCiPMCby9fgUiFw2vxnXsqznxhJfm1undjtLV6jKcf/Jo2U4tjYzjYVeF7rgcunNG
         xnXlIudoDlySf5XxrUpw4mBtVvDwl/OelVFmBPUceFRYbsz3SarU8YZazPq+xvQw4SmR
         1lvZbi0kCicmOJytCoDBXhsKbtgEWvPSzFMEQ7sCn91V1QanlDtGbhbF9SLu95zx/Hun
         aFvKCyNasGDIcMorCKPvgjDMq0DZYP6dWTGSw1kpVi2YP/mZe5p5ydYppw4dhvg1SCeb
         3MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXZyYCnse984T67Wd+QuaLUXZO8UfXRWQ0/2FMXWznM=;
        b=hc69mkS7wbmX2OxMLHuFI2rub1ivuWYvT2fteADvEvKurY37D8rRlKI5UWsf3+z27g
         Ait6cE9w3pMcC9rdstuXOWS2B8NTFwbA3laVcOK5r4J84iUXtJuFFpZlgjiU0StsBSD6
         U9HQx9UoHRZCzCmEhEWP6DuphzZCtonDWy7t7mFEM8400ExwjLI9XWIzsTtcfSU+2JYM
         F/3KpikuBQuezTGQns1E6Vehva/0TCjnERUJqa5vF9pGWI8gXLtA4N4gJHdQ1RuYtVtz
         qNbVrxZ/rVYne4TpGh1D/WvOwSHO7OZOWsSD+y6c643hTBmfXaX9vqf1oqhV5p41wO5p
         QMzg==
X-Gm-Message-State: AGi0PuZP1qMXxK7vWc/RYIGqP+wDSuM33Tjj96xQLv85DF6UgUAJAVQH
        TAuMdPRkzHnaIvoiGmsSQ8pBBbEv6Hv2APOqEd0=
X-Google-Smtp-Source: APiQypKmir2GJ/lpN+uzznF3yfo6IPVkVweaQNfYAL+w/LhiYuhuQt4d5WzO3xy/28fG56tTE8ulXvQSIES2Vhm5LMk=
X-Received: by 2002:a2e:9713:: with SMTP id r19mr3756003lji.89.1586966761283;
 Wed, 15 Apr 2020 09:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200331035459.GA3472@epycbox.lan>
In-Reply-To: <20200331035459.GA3472@epycbox.lan>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Wed, 15 Apr 2020 09:05:50 -0700
Message-ID: <CAJYdmeP+wwLN7fc_6UgFAKOk5yR=OradHtH0MXVhR_TBQD7M5A@mail.gmail.com>
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.7
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <moritzf@google.com>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 30, 2020 at 8:55 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
>
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7
>
> for you to fetch changes up to 3c2760b78f90db874401d97e3c17829e2e36f400:
>
>   fpga: dfl: pci: fix return value of cci_pci_sriov_configure (2020-03-30 20:45:30 -0700)
>
> ----------------------------------------------------------------
> FPGA Manager fixes for 5.7-rc1
>
> Here are two (late) fixes for 5.7-rc1 merge window.
>
> Xu's change addresses an issue with a wrong return value.
>
> Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on
>
> All patches have been reviewed on the mailing list, and have been in the
> last few linux-next releases (as part of my for-next branch) without issues.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>
> ----------------------------------------------------------------
> Shubhrajyoti Datta (1):
>       fpga: zynq: Remove clk_get error message for probe defer
>
> Xu Yilun (1):
>       fpga: dfl: pci: fix return value of cci_pci_sriov_configure
>
>  drivers/fpga/dfl-pci.c   | 6 ++++--
>  drivers/fpga/zynq-fpga.c | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)

Ping
