Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC02CABA2
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 20:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgLATT7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 14:19:59 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43996 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATT7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Dec 2020 14:19:59 -0500
Received: by mail-pf1-f180.google.com with SMTP id o9so1716058pfd.10;
        Tue, 01 Dec 2020 11:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4HBnddxeG8nQ7Q4yBAmvFQXRedJfPDrjBB+3fGH8iF4=;
        b=kkPwZ2tjBh7fcVYKhlE/UhonvMgk5bvjd4c5HK85GSFPhcVJNUy3XOvuiOBnWBP+hc
         fVfCw3tKEszzfP45VfV749jJvxg1I2BpoloMS/VefE4uPo9BHOz6W6v1BW3+AKcxhg57
         wGH7mu9ZSPbNNe4dxSrKKKaqfNKwei/428GOmxUc3VYLLdi+WSPT58igKkK4ydMbAZMl
         azxJNy+0Y13H+G1blK+l0a93lMcPP7Jf6fRXkCsMkeq9wVhwuk0u7dOicBQvOiekcgqY
         znHDFA3xttSnTFVY/sgv+JYVoCWoZbT+mTi59tM6tXQAY5i7qRT43FTcItf6ZXm1+d4X
         DXvA==
X-Gm-Message-State: AOAM530BP3mkWThXp2kB448i5Crz3BVt1qNXO6AHcvMZJ3wvU8v/Pkn/
        fdlEVzXtdA/Dy3qvyE0fcIU=
X-Google-Smtp-Source: ABdhPJx1JUigOEFJfeyUwQfo2ty0FGZJr7SHIRYFbSHnvMX49khY8s0xHvilh89wX+yL3DZ0RCjt/Q==
X-Received: by 2002:a62:8685:0:b029:197:f766:b135 with SMTP id x127-20020a6286850000b0290197f766b135mr4023312pfd.0.1606850358843;
        Tue, 01 Dec 2020 11:19:18 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id a20sm337747pgg.89.2020.12.01.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:19:17 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:19:16 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, richard.gong@intel.com
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <X8aXNKNIPl+piFO+@archbook>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
 <X7U+BTkW7ZmsMByV@epycbox.lan>
 <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
 <X7m6gy/B8DiafyYQ@archbook>
 <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
 <X8XHJimPDaE/lNx0@archbook>
 <e67a2abe-2c97-fe1c-9dc7-100b8a20381b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67a2abe-2c97-fe1c-9dc7-100b8a20381b@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Richard,

On Tue, Dec 01, 2020 at 01:30:16PM -0600, Richard Gong wrote:

> > Can U-Boot determine whether it's the new or old flow? Can you set a
> > different compatible value in your device-tree, to disambiguate
> > behaviors?
> > 
> 
> The boot flow is determined by defconfig during compilation, which means
> each boot flow will have its own defconfig.
> 
> SDM firmware loads SPL into OCRAM, then SPL will load the apporiate ATF or
> U-boot into the DRAM according to the setting of CONFIG_SPL_ATF. If
> CONFIG_SPL_ATF=y, SPL loads ATF and then jumps to ATF. ATF setups EL3
> environment and initialize the PSCI services.
> 
> CONFIG_SPL_ATF is not set for the old boot flow.

So you know at (U-Boot) build time? Can you just pass a different DT to
the kernel in that case?

- Moritz
