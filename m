Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEE288362
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 09:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgJIHWT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Oct 2020 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIHWT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Oct 2020 03:22:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04577C0613D2
        for <linux-fpga@vger.kernel.org>; Fri,  9 Oct 2020 00:22:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so8725424wmd.5
        for <linux-fpga@vger.kernel.org>; Fri, 09 Oct 2020 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FRDO93LNDWBO9t9FG7SMLF0roE6kX6YwpV57FevClu0=;
        b=CfHHtwFc6a6bvulf0veIbCtXAQQpLhc1gE2KdAPVttSYSkRbeqAmws1+Gu3DPMWxZD
         5atKgRcTDPtRmBKt1GiWY7gGEtCEMt06LWPQeCg5GM6Jmrg8eGlDdDq1sbBY8LU8X6YO
         CChGChdM/OIW7FbZZxd5nL/1fKNJbpsQPILg+d6YOSK0AtGfcSjlyj30/IkoNyiT60pv
         LojzvolBcCnsps6JF64PzQW2QZ0groZ5To+V1sdf4pImrItwbGU/cymnyD7lESdppbSH
         W2wGvpU9urMU8vxdHh0GUxArNKlqk82bg2IgmmZ7uIuB2dyU31gT8inHBvuePPo4zmIQ
         Q+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FRDO93LNDWBO9t9FG7SMLF0roE6kX6YwpV57FevClu0=;
        b=eoO4dsgXoN9+ynJdmgSY1iNtq3sY2mNm+GmZ7s8YC1bDLk/30MqO5AO2hUKkIC6wJV
         Eu8GCnQvacu/YGiAb4hUQg8iGmRXeCdZhw25UvUJR4IqUS6aGPxgY7nuduXMrbRqvhd6
         q5NyYUPKGJlu33CKzQBwOH6elqKwc+Dn9jHYSEKYJejIs2H9h1WC6/jHb521CFP4VrSU
         WoQ9zY3GQzOTD/+Bf7yuH/PTJT7k6JHchJ6ksWV7eRNYd97wyO1vYsEUAHh29VEU0TK3
         xni/iHLW1Ms1+bK0kqkvNcK7iRUz2yuSJjwVaa+vmJ8q77TThUCcoDmtDm7znPL3bqzu
         2wEg==
X-Gm-Message-State: AOAM531baLkcxppMEWbIAO9vV6rKrdEBDGSjXC86byrRfRH9Twvw6bLA
        L02VMnOinZSoRCabbyWxsTLGXw==
X-Google-Smtp-Source: ABdhPJzdjCUYMn/4MtXAFjf0Y6Cba+61ceqI/EqZ/a9KT/4y3GfS342ZrklmZNgk9XDx7oht1EJgIg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr11648037wmf.121.1602228137682;
        Fri, 09 Oct 2020 00:22:17 -0700 (PDT)
Received: from dell ([91.110.221.232])
        by smtp.gmail.com with ESMTPSA id t16sm10778955wmi.18.2020.10.09.00.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 00:22:16 -0700 (PDT)
Date:   Fri, 9 Oct 2020 08:22:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v3 1/6] mfd: intel-m10-bmc: support for MAX10 BMC Secure
 Updates
Message-ID: <20201009072215.GJ1763265@dell>
References: <20201009011423.22741-1-russell.h.weight@intel.com>
 <20201009011423.22741-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009011423.22741-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 08 Oct 2020, Russ Weight wrote:

> Add macros and definitions required by the MAX10 BMC
> Secure Update driver.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v3:
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions will be called directly.
> v2:
>   - These functions and macros were previously distributed among
>     the patches that needed them. They are now grouped together
>     in a single patch containing changes to the Intel MAX10 BMC
>     driver.
>   - Added DRBL_ prefix to some definitions
>   - Some address definitions were moved here from the .c files that
>     use them.
> ---
>  include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
