Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB81C7FC4
	for <lists+linux-fpga@lfdr.de>; Thu,  7 May 2020 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEGBRo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 May 2020 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgEGBRo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 May 2020 21:17:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A982BC061A0F;
        Wed,  6 May 2020 18:17:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x73so3011698lfa.2;
        Wed, 06 May 2020 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tVD16UIK2HUykZoQLbybGCDlOmlMC4/rb1eL7D7CrE=;
        b=NFmQCxk3oJ3nTxMshA4z3OOVS1VtKP/Vgprl4bISM0TZG2ApE18sHobhx/PFWs6/uc
         LC9lVUthwUINP/zaL4xoNEmJ2VFnnxeJ3cFln6hDdaE2aTPpEr62Bj8r7E0MKKk9jT0O
         m1V2IayvHJJhJ7fYQSMMF8jRiIXmH19hJBIse2JqsrjGxt54AyUf8R6KitlF84mtReRY
         nMSSLxoB9m+SpecnSO58V7CxIsCF6c0lf3Uh37a8FWs6ijVJAkWY3Y7QcVir9SGAQW4B
         fglrDWoY0sG3qRiBG7U0YqoZIxIej4+Wih4kJfqJVqefaIZEq2bL4PWXmOxmQHowkE+a
         u5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tVD16UIK2HUykZoQLbybGCDlOmlMC4/rb1eL7D7CrE=;
        b=PtShuWE0VR9RNpB81+/xzCDRY2M5+IsyzvQ+h2CzVuVQxzYCVpcXLjaZLe5tJDsSDk
         RPRBwM7GIg8aCOZtAgBWjT2F8GY8QVUi1pmHQOEqEj67gzB65UoCHrDKrEsiCGejpyf5
         aHwSq5sTFYlqVdD3BXsKtkEEKgJT9YVMZlyBytKxbmpfhDtqTVl8h1Qckp/dVqXjMINi
         dGzckHaahrIC72mhu1hBn8ROQERWfMbBeNahtCRnxHspF7VMnFc/UbP7QQPVhHkBsfEz
         wcpoQ1zOjjVwYenlK+jdwKUXHZKwdLai57EHUNFxsEDA12IS9t7lRjQPMb/2OkQXK6R/
         yUuw==
X-Gm-Message-State: AGi0PuZb180e1AUnIzzbRMxSUiiDHQF5brCf2QdFN4yLW/oVPmmA/OvT
        0nRPV+9xubXrWHxBDxsNORyRTUfbP/9AmvUz9Hy8PA==
X-Google-Smtp-Source: APiQypLIcEJVXCrwurHq/Ev2YP2PtFWYe5xadzI8BVmHoWL7CPL4HhQlOGm2xi8BYSGTzrBLuWglxpRe70k0sQfX/hE=
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr7095093lfg.150.1588814259888;
 Wed, 06 May 2020 18:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com> <20200506051040.GB31302@yilunxu-OptiPlex-7050>
In-Reply-To: <20200506051040.GB31302@yilunxu-OptiPlex-7050>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Wed, 6 May 2020 18:17:27 -0700
Message-ID: <CAJYdmeMjeHNX9c6_gZ2HAdYO=JthEqxvAWG1+6M5_SAXMD8Fpg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add interrupt support to FPGA DFL drivers
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trix@redhat.com, bhu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Tue, May 5, 2020 at 10:13 PM Xu Yilun <yilun.xu@intel.com> wrote:
>
> Hi Moritz:
>
> Hao and I did several rounds of review and fix in the mailing list. Now
> the patches are all acked by Hao.
>
> Could you please help review it when you have time?

I'll get to it this weekend. Sorry for the delay,

Moritz
>
> Thanks! :)
>
> On Mon, Apr 20, 2020 at 04:11:36PM +0800, Xu Yilun wrote:
> > This patchset add interrupt support to FPGA DFL drivers.
> >
> > With these patches, DFL driver will parse and assign interrupt resources
> > for enumerated feature devices and their sub features.
> >
> > This patchset also introduces a set of APIs for user to monitor DFL
> > interrupts. Three sub features (DFL FME error, DFL AFU error and user
> > interrupt) drivers now support these APIs.
> >
> > Patch #1: DFL framework change. Accept interrupt info input from DFL bus
> >           driver, and add interrupt parsing and assignment for feature
> >           sub devices.
> > Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
> > Patch #3: DFL framework change. Add helper functions for feature sub
> >           device drivers to handle interrupt and notify users.
> > Patch #4: Add interrupt support for AFU error reporting sub feature.
> > Patch #5: Add interrupt support for FME global error reporting sub
> >           feature.
> > Patch #6: Add interrupt support for a new sub feature, to handle user
> >           interrupts implemented in AFU.
> > Patch #7: Documentation for DFL interrupt handling.
> >
> > Main changes from v1:
> >  - Early validating irq table for each feature in parse_feature_irq()
> >    in Patch #1.
> >  - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
> >    instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
> >    DFL_FPGA_FME/PORT_XXX_SET_IRQ param
> >
> > Main changes from v2:
> >  - put parse_feature_irqs() inside create_feature_instance().
> >  - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
> >  - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL
> >
> > Main changes from v3:
> >  - rebased to 5.7-rc1.
> >  - fail the dfl enumeration when irq parsing error happens.
> >  - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
> >    drivers.
> >
> > Main changes from v4:
> >  - Minor fixes for Hao's comments.
> >
> > Xu Yilun (7):
> >   fpga: dfl: parse interrupt info for feature devices on enumeration
> >   fpga: dfl: pci: add irq info for feature devices enumeration
> >   fpga: dfl: introduce interrupt trigger setting API
> >   fpga: dfl: afu: add interrupt support for port error reporting
> >   fpga: dfl: fme: add interrupt support for global error reporting
> >   fpga: dfl: afu: add AFU interrupt support
> >   Documentation: fpga: dfl: add descriptions for interrupt related
> >     interfaces.
> >
> >  Documentation/fpga/dfl.rst    |  19 +++
> >  drivers/fpga/dfl-afu-error.c  |  17 +++
> >  drivers/fpga/dfl-afu-main.c   |  32 +++++
> >  drivers/fpga/dfl-fme-error.c  |  18 +++
> >  drivers/fpga/dfl-fme-main.c   |   6 +
> >  drivers/fpga/dfl-pci.c        |  80 +++++++++--
> >  drivers/fpga/dfl.c            | 310 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.h            |  57 ++++++++
> >  include/uapi/linux/fpga-dfl.h |  82 +++++++++++
> >  9 files changed, 612 insertions(+), 9 deletions(-)
> >
> > --
> > 2.7.4
