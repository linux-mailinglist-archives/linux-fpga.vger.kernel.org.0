Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7037961B
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhEJRin (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:38:43 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38546 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhEJRim (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:38:42 -0400
Received: by mail-pl1-f179.google.com with SMTP id 69so4885464plc.5;
        Mon, 10 May 2021 10:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FqksKLFJgYxQZl9Y18SHfYPa3tKgodRoYiwD/TGaez8=;
        b=jMSJ3eeaCf1Qn71+OUoPckItnqJ3jYmYpkP+8fKUzxTNJcxio9LEg4Kp0uQPqTuSDb
         iq5DQltkO9wV3B7jMgawb2n7HchAgAhDbprdf+6gtgGdVqElH7aTuIEHPsPpovY07fx8
         i96D7qu9rMjjpkxjKrhZiMUIAGYzCNTGOsKOfUpmamDGNPs0gdvkzoy3EUFz9N+sZgkY
         iCPqT3CsJjj5zpkKDAPMBokRyQICjI8GHbIgtSDvZYlYbHmbmjSd3d+9U763rBfzZxp5
         lbendjb27qGHQtjn5Ik2Q1bhMeTZ9HkkHW8ffN1HH1OGLMosQG7jpN/IWXqv3h+NPDol
         CVQw==
X-Gm-Message-State: AOAM530ZJfHvh/me3ajpNbHVVawShQHfcZKgrf6r0UF0qk1JkbjihbZn
        vtgBXk0+k4UuvPim+KFs10s=
X-Google-Smtp-Source: ABdhPJyPS4jdZ3WuTm+roRCvA8KQ2yLi3GuoeeYR2tSTGDw6XroMsneTKnEr7qLcluPSJ1nke0tsNw==
X-Received: by 2002:a17:902:a60f:b029:ee:cc8c:f891 with SMTP id u15-20020a170902a60fb02900eecc8cf891mr25114543plq.39.1620668257796;
        Mon, 10 May 2021 10:37:37 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s8sm11737251pfh.108.2021.05.10.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:37:37 -0700 (PDT)
Date:   Mon, 10 May 2021 10:37:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v12 0/7] FPGA Security Manager Class Driver
Message-ID: <YJlvYNXUcwrBFGey@epycbox.lan>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <6f3ce0db-883e-2c5b-e671-9ccc363ee532@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f3ce0db-883e-2c5b-e671-9ccc363ee532@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 10, 2021 at 07:12:57AM -0700, Tom Rix wrote:
> 
> On 5/3/21 2:35 PM, Russ Weight wrote:
> > The FPGA Security Manager class driver provides a common
> > API for user-space tools to manage updates for secure FPGA
> > devices. Device drivers that instantiate the FPGA Security
> > Manager class driver will interact with a HW secure update
> > engine in order to transfer new FPGA and BMC images to FLASH so
> > that they will be automatically loaded when the FPGA card reboots.
> 
> Russ,
> 
> These have my Reviewed-by, but since it has been a while, I am looking these
> over again.
> 
> If you do not hear anything from me in the next couple of days, please
> assume everything is fine.
> 
> Tom
> 

I'll do one more one-over, if it looks good will apply end of the week,

- Moritz
