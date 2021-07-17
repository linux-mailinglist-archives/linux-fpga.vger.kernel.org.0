Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD283CC6F5
	for <lists+linux-fpga@lfdr.de>; Sun, 18 Jul 2021 01:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhGQX7E (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 17 Jul 2021 19:59:04 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46799 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhGQX7E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 17 Jul 2021 19:59:04 -0400
Received: by mail-pg1-f182.google.com with SMTP id w15so14672658pgk.13;
        Sat, 17 Jul 2021 16:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QBPwPehfJNZ2LsnsANIrsrlPDWfZeZDsGvfQK0F94As=;
        b=S0PaLnwSYGufGz78bspThIaR3flxvTT42VFinQ5EJQ5XcUW1Je8N5l1jVDKgFHHOpr
         F/m5Ty5TXlEDRXa9FOkSURjDiH6oe0AznJVyx1YuFTaZx7onP5LTcqKcrAmu4YBPP9aF
         9z72Qlnrl/NddYsoY0dB66OOteQVd1Rd3B5n9+8VVtZW4BEnXURLSiqf8cRT7IIf1/SY
         zFZwWFkg/TltI9JY/Gn4bGjoA1uGHFNhOuqDlM+GRoD+aVDKjwHYrqMR5A+FUFfwMnsa
         EZw7LIXSF/dD5n5YZCyzvLBer6xTWpOxOgQsBdCDMehX1CCjWNU08E+SSYzuJAE9PZ2z
         dwwA==
X-Gm-Message-State: AOAM530qiMOHE1IsAKb/EdmgRjEc3UYSffllLXk7c1SlOlNX13/6hWZU
        trsbsCK3FOxfg+DIZy1LVG8=
X-Google-Smtp-Source: ABdhPJyCGy2eEB94sfSOMS2sxY2uL1l2UjzA/JuHNafcDXLUC8Tuce2jhHchh+W2EkQMQWbo+UKyjA==
X-Received: by 2002:a65:6248:: with SMTP id q8mr17609947pgv.279.1626566166808;
        Sat, 17 Jul 2021 16:56:06 -0700 (PDT)
Received: from localhost ([24.4.24.239])
        by smtp.gmail.com with ESMTPSA id h5sm14030558pfv.145.2021.07.17.16.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:56:06 -0700 (PDT)
Date:   Sat, 17 Jul 2021 16:56:05 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/3] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <YPNuFX4ZfwJoOlMk@epycbox.lan>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-3-martin@geanix.com>
 <20210716173335.GC4137@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210716173335.GC4137@sirena.org.uk>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 16, 2021 at 06:33:35PM +0100, Mark Brown wrote:
> On Fri, Jul 16, 2021 at 03:54:40PM +0200, Martin Hundebøll wrote:
> > From: Martin Hundebøll <mhu@silicom.dk>
> > 
> > The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> > existing BMCs, so use a dedicated feature revision detect it.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Mark do you want me to provide a tag for this and the previous commit to
avoid conflicts for other FPGA changes or do you think it's easier to
just pick both of them up through FPGA or SPI tree?

- Moritz
