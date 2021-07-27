Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312333D6E44
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 07:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhG0FnV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 01:43:21 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:37555 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhG0FnU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jul 2021 01:43:20 -0400
Received: by mail-pj1-f46.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso2559460pjq.2
        for <linux-fpga@vger.kernel.org>; Mon, 26 Jul 2021 22:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmcZSpGmxKNLN/U+QB8gWVSkn+32talujLOR2C9Cxx4=;
        b=JaFbXQu8546Y7Za4vzL0B9TdGikS/Qsa07KCf5aYW6RnYNDCp6XaWjY5fobZIUcx4t
         e9AJONiMq8wQ2u1qQL7/Hz/3nO7mqMH09MM3T0QGp0xQRx3oFXVtHWPPgtuFWkqSKAt9
         /qNq9qa8RseklfUzEvBfctOUilE/8J8Jm4hMUeqEqFv36CH8MoctfPT5YAB4ZBZpH2kq
         rscEVYzkUtGYRFPW0KWJvolJ9FvPg/5zhp9yWnbG646EwmQRkGQuGGhMKFHNChl/Q/Dl
         djM67G47MIhbX8EWblBx7PNo8uY4YEI8+AN4olzhmRWmdyLVODxY0RmeK1SNCQjb9sr9
         4D6Q==
X-Gm-Message-State: AOAM530nE+kVO28tBo2tafXtsrvLSXzpOoaAk52sXFlu+Fuh0kdD+Fhm
        PiRlI5S7qFxtMfXlqU9OQZk=
X-Google-Smtp-Source: ABdhPJwez69R55xS24j/lmlV/ubFjAjs9AHjqEG/i63SmflKl1r7bNqzCTVmwUgDrucq6DIFjPJc4w==
X-Received: by 2002:a63:cd4b:: with SMTP id a11mr21867547pgj.273.1627364601325;
        Mon, 26 Jul 2021 22:43:21 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id l2sm1919369pfc.157.2021.07.26.22.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:43:20 -0700 (PDT)
Date:   Mon, 26 Jul 2021 22:43:19 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
 function
Message-ID: <YP+c98m5AhrGQWDe@epycbox.lan>
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Mon, Jul 26, 2021 at 02:33:29PM -0700, Russ Weight wrote:
> Hi Moritz,
> 
> I sent this version of the patchset out on July 8th. The only discussion has
> been around the compat-id structure. I think there is agreement that this can
> be treated separately. What are your thoughts? Do you think this patchset is
> ready?

It generally looks good. Let's take another look once Greg pulled in the
changes (since there'll also be the new Versal driver and Tom's changes).

- Moritz
