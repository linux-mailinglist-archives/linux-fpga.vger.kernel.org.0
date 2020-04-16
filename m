Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339B91ACE2A
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403963AbgDPQ45 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 12:56:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729614AbgDPQ44 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 16 Apr 2020 12:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587056213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtqJ90xdaaArC4Wt+UP95sE7yqWa9iDJbaqMvVSt4X0=;
        b=EC637tWDNYMmWLlaiicuu4HsiqL3uJM2TiATymIvSrTKv66flXG5ZkTC4IYYOPRxoH4Dc2
        MSDOi/Zw/FV0BTc++9HjDNdDSPlAaCY9pegVeXrKT8T20DFK9gaD05hYNnMyaSZAsBDihQ
        qGsqjDGDypWqKwnRN/WridcUFu86Iwg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-rtkH0f_OO82BnNmYDUaXgw-1; Thu, 16 Apr 2020 12:56:51 -0400
X-MC-Unique: rtkH0f_OO82BnNmYDUaXgw-1
Received: by mail-qv1-f72.google.com with SMTP id es18so3905427qvb.9
        for <linux-fpga@vger.kernel.org>; Thu, 16 Apr 2020 09:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FtqJ90xdaaArC4Wt+UP95sE7yqWa9iDJbaqMvVSt4X0=;
        b=rEsYoSEpZBrLE/jjV2MAfHdGMClj76UciQGazklEAYtO8i0DwBy/RWOLOu7aRA7UWK
         aS1a1s8xkWgiUtz8j9GbVZnIwtMGQssN6iJzYmmNnPzfsk4Kyamfrnng6oQYW4oTQHC3
         9neFLPsvQjK7PqJfHFK9Z1MGbrXc9oTSAD8gUsUGMv3WKukWlIJlmWIv48eBfVBU9C2Q
         FDkYl+fR/AxeAqSJF09MMVBV9Pu0lO+Fc0W2ylAy/SQvqaD++YdEF+WYvoqzRSJb22Gb
         RzN6kQBVapxeN3L9iEDpBsiChYnLMwqyFP5cmvENOTpAuuhRsBeXJHrDp5CkKHfLcXT3
         vxcg==
X-Gm-Message-State: AGi0PuYzAPIzVRi6qGzPZJpVC4kgtZHM8GQABOfTM1yNuqvRbKeDlSRs
        fus76EqLD+GvXOb+tdpBkG89nxdlW/S/Z73LgI8RFLfbVudSslA8mj8YEnfqWWHWJuX5/MI0zAQ
        qkn0NwGpGMkTOagjniBNOag==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr22103003qkm.272.1587056211050;
        Thu, 16 Apr 2020 09:56:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypISGwMhzI4XgAte4arKs5cwA/hMNtaSO2/TYLJCXRGvthdsD3ysU+JITN4tZMZtQ4vVgyLw6A==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr22102984qkm.272.1587056210851;
        Thu, 16 Apr 2020 09:56:50 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c33sm11855109qtb.76.2020.04.16.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:56:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "bhu@redhat.com" <bhu@redhat.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
Date:   Thu, 16 Apr 2020 09:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Please check the scope.

On linus/master, the result of this change looks like

static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
{
    struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
    struct dfl_fpga_cdev *cdev = drvdata->cdev;

    if (!num_vfs) {
        /*
         * disable SRIOV and then put released ports back to default
         * PF access mode.
         */
        pci_disable_sriov(pcidev);

        dfl_fpga_cdev_config_ports_pf(cdev);

    } else {
        int ret; <--- defined here

        /*
         * before enable SRIOV, put released ports into VF access mode
         * first of all.
         */
        ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
        if (ret)
            return ret;

        ret = pci_enable_sriov(pcidev, num_vfs);
        if (ret)
            dfl_fpga_cdev_config_ports_pf(cdev);
    }

    return ret;  <---- not in scope, not defined here
}

Tom

