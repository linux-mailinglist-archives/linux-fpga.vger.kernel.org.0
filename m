Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F83A05CB
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhFHV0M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 17:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234382AbhFHV0L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 17:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gIQrxNh8rCNXWF5A+cmW2C8HVpKFKLZxYRvN1nK0FM=;
        b=DZC68nlWpfP8gNU+QNGNti/X7SOXmhStYsgIi33S5P/2sK/WKDkPi5TE1OpVcqZBE3D+jc
        j7TquuakCYslcFuvsXrx+5KwerPCJ0U3tiLJpM59/a1QTy9WCtf97kAj3UgSVhzRl8W6K+
        D/CsiTiwDgYYKLZXpd9UGQKpntCnlLE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-ix85guGwOISxt7KcAAC0Ag-1; Tue, 08 Jun 2021 17:24:14 -0400
X-MC-Unique: ix85guGwOISxt7KcAAC0Ag-1
Received: by mail-oo1-f69.google.com with SMTP id l13-20020a4aa78d0000b0290245c8f11ac2so14060311oom.11
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 14:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gIQrxNh8rCNXWF5A+cmW2C8HVpKFKLZxYRvN1nK0FM=;
        b=RBJ2Basq0pw6yGx/vhSqLqdrR9F+joSDzhHp0vXw6H5mm+l6ZLi5oZjYp7RehTMsWW
         BBub3n1fROE9eP6zXYE+j+7MOeBScxuE75eal4BDANuezlQigMtEmq1ysRevh6TyVPRm
         f+dvfkZ60I4tNdm0w6zuKHy4AO4ZWtHzx6j9i2QKXipexUzy/A7EiUfYTwaSzmM/6mIQ
         BAkPzWKiYD/44olOMXNj7N3nI3THykEyXwb5BoOyy6U3rad50USpzo1qXc67Sndi7/8q
         oYOn2Qj9N3W3KsRsCMXxVXgWLteh9BW/+sQS5t50KHsUb/Ucjwa1DIUYZKavW5LdMKK4
         I2ZQ==
X-Gm-Message-State: AOAM530fWlY0vFOeRoE6YrtuHSzVQ4uNX10zaSOlTajfZdsX/L9NRN29
        d7EDdwPelG5mvnuNTxUWPqLbVN1IYxsreDJtZnaIYh4nDf4YYCHJ+Lm/ss7DnHMzlfwlQQ4OlCF
        Tc6pVVhMQm53wzzavqKM6Sw==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr4182085oic.123.1623187453961;
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXsoUQfchNBKnL8EdmQmEAp/5gAc1hlFks6ooIHfYu2jxHqDv442A3KNzBoqbETAUPGj1thg==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr4182055oic.123.1623187453793;
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:13 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 05/11] fpga: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:44 -0700
Message-Id: <20210608212350.3029742-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc7..8cd454ee20c0c 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -7,7 +7,7 @@ menuconfig FPGA
 	tristate "FPGA Configuration Framework"
 	help
 	  Say Y here if you want support for configuring FPGAs from the
-	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
+	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
 	  manager drivers.
 
 if FPGA
@@ -134,7 +134,7 @@ config FPGA_REGION
 	tristate "FPGA Region"
 	depends on FPGA_BRIDGE
 	help
-	  FPGA Region common code.  A FPGA Region controls a FPGA Manager
+	  FPGA Region common code.  An FPGA Region controls an FPGA Manager
 	  and the FPGA Bridges associated with either a reconfigurable
 	  region of an FPGA or a whole FPGA.
 
-- 
2.26.3

