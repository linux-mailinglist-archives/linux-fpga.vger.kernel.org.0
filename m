Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818BB3B67AD
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhF1Ra5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 13:30:57 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42612 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhF1Ra4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 13:30:56 -0400
Received: by mail-pg1-f182.google.com with SMTP id d12so16009261pgd.9;
        Mon, 28 Jun 2021 10:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TPuWmBUlipmneUEeRZ9VUhDX5+XS8G4OvGR2i434oPY=;
        b=cQ4tzAyPjQWavGb2T6spEZ2NYe8+w6ZsKdo5eKPEvHv11mCZxXhBPs1tpRSVCv0Oqb
         3AS6vno6Ri+CfIUwYmn96vcCMY2N44L4LDVuShATKaqQE98RWzOGIoCLG5OUTGIdodf9
         fpLCJLQs0QBHZBAG5BB9Go20ZgPAM8ctDMNZvKuxoDKVQPXD7Ys8br6NzMWIKupQQcIx
         0d9c66ewtplIqiz8dhXi5tgCyb0KVWbB5LVNtDmrS6MGSev/g+IT+uTFuaR54ry4+jja
         b92L+n2pH1HVhxyescQcmjd/mwUvCxInaasQMXAYljDLG8dZdJp/zqite3JSZl1Aao6t
         lOVg==
X-Gm-Message-State: AOAM532KGbaSdpZlpBlq9kpgtVaM9nzlMGM7jZFfARnhRfwfZiNjibRu
        d3eyvTdFJebeXyQ9OW8HWMM=
X-Google-Smtp-Source: ABdhPJwzH5F38culUsWjH/Gkjc4yp8t6YOVA31U7C4pqDfrHdJ8Jy3lSyFc7zd6Bd6D4rEgchFU4sA==
X-Received: by 2002:a63:f20:: with SMTP id e32mr24377461pgl.235.1624901310593;
        Mon, 28 Jun 2021 10:28:30 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y80sm15278566pfb.204.2021.06.28.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:28:29 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:28:28 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Message-ID: <YNoGvOhMQHsqXWfc@epycbox.lan>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-6-martin@geanix.com>
 <20210628163556.GB445250@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210628163556.GB445250@roeck-us.net>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Guenter,

On Mon, Jun 28, 2021 at 09:35:56AM -0700, Guenter Roeck wrote:
> On Fri, Jun 25, 2021 at 09:42:13AM +0200, Martin Hundebøll wrote:
> > From: Martin Hundebøll <mhu@silicom.dk>
> > 
> > Add the list of sensors supported by the Silicom n5010 PAC, and enable
> > the drivers as a subtype of the intel-m10-bmc multi-function driver.
> > 
> > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> 
> For my reference:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Moritz Fischer <mdf@kernel.org>

> 
> Not sure if I can apply this patch as-is to hwmon, or if it needs
> to wait for the other patches in the series. Any thoughts / comments ?

I don't see how it would break anything in itself since it just adds
extra compatible and data.

I'd probably wait with applying until discussions around the mfd and dfl
parts are resolved since otherwise there's no user.

> Guenter

Thanks,
Moritz
