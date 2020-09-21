Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74470271BAE
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 09:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUHXR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 03:23:17 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43400 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIUHXR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Sep 2020 03:23:17 -0400
Received: by mail-ej1-f66.google.com with SMTP id o8so16209028ejb.10;
        Mon, 21 Sep 2020 00:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+7B+gIe1GiyZpzIr11BAn4D6KaI7ycX6F9Bp5RKU+Y=;
        b=TMeja3zwAp7LgaW9bXZ0mqy4h+uQQ9eYylr2lS5W8V8LPiIkA/RepvOJ7pr31od01H
         pQFo68lVm3EZnqAFW2AwnVPE0nuHKtCsWs0CkSGzb9E67RcMxSsbgV4NjHUP//nv+DFn
         IVVYlq72XOZbAk3mNBhSgXtruoMlVik78++0l66dQGPKQuj4yjScj5yeLRL0RNb12Ibz
         2aoD+mDnLrAJPNg6uHkxwVMdRJ1XJxiPs1AJ26vm4Y5jM91StlL9w22Mpe7RrziwctSv
         NgJqyg1nBjnrFHKrUy1LmQSLAsVYnvZ/YUEHh4mQpFrK5fq28j34/ddbs9j/Z/DNAktJ
         e5kg==
X-Gm-Message-State: AOAM531Ewp4IaHIkHEQepL859gTr1L2vLnBrn2I5yAl8TUkYLMb/Unmq
        IHJ9QAy3ZDSx3yZP0kGn2gMXNY3LEM8=
X-Google-Smtp-Source: ABdhPJx1jUoVvQEIs0x1IkeQqM6/NtMpDIIL2VQETj4IKdf7iK3PZSDlL6FKPbIZaBc0C1Z5XHMfkg==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr47245224ejf.97.1600672995454;
        Mon, 21 Sep 2020 00:23:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id x12sm7976967edq.77.2020.09.21.00.23.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 00:23:14 -0700 (PDT)
Date:   Mon, 21 Sep 2020 09:23:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3] memory: dfl-emif: add the DFL EMIF private feature
 driver
Message-ID: <20200921072311.GA6133@kozik-lap>
References: <1600666280-25651-1-git-send-email-yilun.xu@intel.com>
 <1600666280-25651-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600666280-25651-2-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 21, 2020 at 01:31:20PM +0800, Xu Yilun wrote:
> This driver is for the EMIF private feature implemented under FPGA
> Device Feature List (DFL) framework. It is used to expose memory
> interface status information as well as memory clearing control.
> 
> The purpose of memory clearing block is to zero out all private memory
> when FPGA is to be reprogrammed. This gives users a reliable method to
> prevent potential data leakage.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2: Adjust the position of this driver in Kconfig.
>     Improves the name of the Kconfig option.
>     Change the include dfl-bus.h to dfl.h, cause the previous patchset
>      renames the file.
>     Some minor fixes and comment improvement.
> v3: Adjust the position of the driver in Makefile.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
> 

Hi Moritz,

Since this depends on dfl patches, I would need a stable tag with them
or you can take it directly:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
