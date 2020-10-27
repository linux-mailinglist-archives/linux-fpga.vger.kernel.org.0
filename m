Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9AC29AA17
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Oct 2020 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898752AbgJ0Kzv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Oct 2020 06:55:51 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39849 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898751AbgJ0Kzu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Oct 2020 06:55:50 -0400
Received: by mail-ej1-f65.google.com with SMTP id bn26so1561323ejb.6;
        Tue, 27 Oct 2020 03:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TymBfd8xbolCDz0CTS1KfmPjnSowqs0JmWS/4o61x3A=;
        b=P7BJKbaF+t3ZrZ2zc2Hs9tOb4gSZsq2XkPvXA3H92tt/xCuttznHJdyIWPL5qGl7XI
         thdMCPXWrg4tZndI2ZZQq2QQO2LXz60kuIvxBQYWIJmPqmUnT93XH5LNixFnh+KhmVy+
         xI3x8qfq3MFo9EaltLPgn9kfi2QnslFKZvnTwJlh1yQoz++QXD20xOUItCQgTcGSq0Zp
         JUXLCmJDrQp+SnMC5PxDHs1IUo6YiSDSVCQtO9wX+mH3uzeg1vt7wxmugturNNZz/c8A
         +cvUtpaH1FennvPnH8a/3SmrnVzb2c/NC48b19l0SeLUiYG2uKGvYXYLDi+8K2Xqpp0m
         zuuw==
X-Gm-Message-State: AOAM531PzrIM6ok95OxJ+lIoOcQiEpQrHHOAIbCIo2EBDwWxkiUx3P3I
        HCWli2y4aWJTbuHZbSpOQHrLJJYYpZLnoiec
X-Google-Smtp-Source: ABdhPJzR8tVVWkkowm2YOT8iAGu+2wm47ujgioM2a27CEFF7xhn8/NwoA5feiGr9Ro970g2q9PIJ9w==
X-Received: by 2002:a17:906:2649:: with SMTP id i9mr1833196ejc.449.1603796148893;
        Tue, 27 Oct 2020 03:55:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id z2sm724219edr.64.2020.10.27.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:55:47 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:55:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v11 2/2] memory: dfl-emif: add the DFL EMIF private
 feature driver
Message-ID: <20201027105545.GB20676@kozik-lap>
References: <1603790581-4487-1-git-send-email-yilun.xu@intel.com>
 <1603790581-4487-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603790581-4487-3-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 27, 2020 at 05:23:01PM +0800, Xu Yilun wrote:
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
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Feel free to take it via DFL tree.

Best regards,
Krzysztof
