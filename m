Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D5286F4F
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 09:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJHHYC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Oct 2020 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJHHYC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Oct 2020 03:24:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492E1C0613D2
        for <linux-fpga@vger.kernel.org>; Thu,  8 Oct 2020 00:24:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f21so5293251wml.3
        for <linux-fpga@vger.kernel.org>; Thu, 08 Oct 2020 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=51bhbv7Q6y4/rGYHYq4fR0iaqpAhvfl/QOeD7oDUgoY=;
        b=Sz4LrZs5sa3octu3Z1A9s+T5d/i+MGIkvGmGM1rxCnwKGbOcznbtt/HDXrMEVDfsqa
         RslLmR8ukkTsWqHOlEReH3W5wtfyxJSAYdd7uz3y0RiR+T++OVv071N3AFA/xB26+qZN
         EnSTjmvZ6TACHOBMcXRD8raf3tsJdzVrp0KYJPpFrs/8w+KAG8MwsxkkU53RUk6WzSic
         wtbU9z8F3TuhPjMwzBE9YtYf46BUWPZQw4mQX+Rk9uns/YLCYagsHREzg6PLUWxizgMg
         SDfv+tlw8RTTJ3JkFuZ5aUE5ldEyM/XHr8r185QBx+pH6wb7tMC9vs57UHu8q9zsFHTN
         OIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=51bhbv7Q6y4/rGYHYq4fR0iaqpAhvfl/QOeD7oDUgoY=;
        b=jfw+7Yc3wPhW+I+bzoxoZxSWcb+aL/iuvUVSBfB+U9i4KGd72PSvMXCwcSnmqN8E+9
         IxygjmAIIBS4sT5TM5H0RTKpAifRF5VHp0IFh601yDSMzwZ3oNfrHe2Pyt6cZ+TzMotu
         +Q3sMmx8pjjZpBzMggBukvJob4vd/bRLIkfk2HpkJIl1teWsbxGrRSfFyVia2jC0mLWk
         EbGxG8wI2Kd9D0Qf+Gjmc81eN1HCuMBUBKMT/vv/vAvG7Is38hu8yZe69u3J/Mrvt1b1
         N1EBtUP1WQdqdmaYFYS3TZEYhSppcyK8MYPcRZ3+WVlKMrC9oPquSpVtHLv0C8vfdmQf
         kz1A==
X-Gm-Message-State: AOAM532ZaHLGrcE2AnLq8UcYBJd7GW6Bl4QVsvHkBJ9tLS/ZqJCdFFYJ
        QQuOf25fArhjhxvDWwwVUDz/GQ==
X-Google-Smtp-Source: ABdhPJx2zS+4ltiDHMYeaoKp07Jhp4uEQ4HL8oiyNbsAbmYlk1jLvA611SMEj/Hfn3iMJn7GnhL40w==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr6817704wmc.184.1602141840369;
        Thu, 08 Oct 2020 00:24:00 -0700 (PDT)
Received: from dell ([91.110.221.232])
        by smtp.gmail.com with ESMTPSA id o6sm5984050wrm.69.2020.10.08.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:23:59 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:23:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC
 Security Engine
Message-ID: <20201008072357.GD1763265@dell>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
 <20201007070059.GB1763265@dell>
 <c50c30b7-0693-3ff1-8d79-5d311d3831bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50c30b7-0693-3ff1-8d79-5d311d3831bd@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 07 Oct 2020, Russ Weight wrote:
> On 10/7/20 12:00 AM, Lee Jones wrote:
> > On Fri, 02 Oct 2020, Russ Weight wrote:
> >
> >> Add macros and definitions required by the MAX10 BMC
> >> Security Engine driver.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> ---
> >> v2:
> >>   - These functions and macros were previously distributed among
> >>     the patches that needed them. They are now grouped together
> >>     in a single patch containing changes to the Intel MAX10 BMC
> >>     driver.
> >>   - Added DRBL_ prefix to some definitions
> >>   - Some address definitions were moved here from the .c files that
> >>     use them.
> >> ---
> >>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
> >>  1 file changed, 134 insertions(+)
> >>
> >> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> >> index c8ef2f1654a4..880f907302eb 100644
> >> --- a/include/linux/mfd/intel-m10-bmc.h
> >> +++ b/include/linux/mfd/intel-m10-bmc.h
> >> @@ -13,6 +13,9 @@
> >>   * m10bmc_raw_read - read m10bmc register per addr
> >> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
> >> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
> >> + * m10bmc_raw_update_bits - update max10 register per addr
> >>   * m10bmc_sys_read - read m10bmc system register per offset
> >> + * m10bmc_sys_update_bits - update max10 system register per offset
> >>   */
> > FWIW, I *hate* abstraction for the sake of abstraction.
> >
> > Please just use the Regmap API in-place instead.
> >
> I was following the discussion on the Max10 BMC driver to determine which way to go:
> 
> https://marc.info/?l=linux-kernel&m=159964043207829&w=2
> 
> My understanding was that the existing function wrappers were accepted because:
> 
> (1) The functions are adding dev_err() calls that would have to be replicated
> for each call if we don't create a new function.
> (2) The _sys_ macros are adding a base address offset, which facilitates
> sharing code between multiple devices (although only the n3000 is supported with
> the current patches).
> 
> Would you prefer that we handle these on a case by case basis? And only provide
> wrappers for the ones that have high usage?

Yes please.  As I said in the link above, avoid them it at all
possible.  If you and every other user needs to place an error message
after every single call, consider moving the error message into the
API itself.

There are 10's if not 100's of different API calls where users
normally place error messages following them.  To abstract them all
for each platform would be insane.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
